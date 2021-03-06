#   Copyright (C) 2019 James "Nornec" Ratliff
#
#   This file is part of Midinous
#
#   Midinous is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   Midinous is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with Midinous.  If not, see <https://www.gnu.org/licenses/>.

class Proc_Midi
	attr_accessor :out_list, :in_list, :in_chan
	attr_reader   :out_id,   :in_id, :in, :midi_in

	def initialize(oid,iid)
		@out_list = []
		@in_list  = []
		@in_chan  = 1
		
	  @out_id = oid
		@out_list = UniMIDI::Output.all
		@out = UniMIDI::Output.use(@out_id)
		
		@in_id  = iid
		@in_list  = UniMIDI::Input.all
		unless @in_list.length <= 1
			@in  = UniMIDI::Input.use(@in_id)
      set_listener
		end
	end
	def regenerate
		@midi_in.close unless @midi_in.nil?
		@in_list.each  do |i| 
			#i.clear_buffer
			i.close
		end
		@out_list.each {|o| o.close}
		UniMIDI::Input.all.each  {|i| i = nil}
		UniMIDI::Output.all.each {|o| o = nil}

		@in = nil
		@out = nil
		
		@in_list = []
		@out_list = []
		
		UniMIDI::Loader.clear_devices

		@in_list  = UniMIDI::Input.all
		@out_list = UniMIDI::Output.all

		UI.set_device(0,"i")
		UI.set_device(0,"o")
		
		set_listener unless @in_list.length <= 1
	end

	#Restart the listener
	def set_listener
		@midi_in = GuiListener.new(@in)
		@midi_in.listen_for(:class => [MIDIMessage::NoteOn]) do |e| 
			Pl.set_note_via_devc(e[:message].note.clamp(0,127)) if e[:message].velocity <= 127
		end
		@midi_in.gui_listen
	end
	
	#Select the output device
	def sel_out(id)
		@out = UniMIDI::Output.all[@out_id].close
		@out = UniMIDI::Output.use(id)
		@out_id = id
	end
	
	#Select the input device
	def sel_in(id)
		@in = UniMIDI::Input.all[@in_id].close
		@in = UniMIDI::Input.use(id)
		@in_id = id
		@midi_in.close unless @midi_in.nil?
		set_listener
	end
	
	#Sends a note to an instrument
	def note_send(channel,note,velocity)
		@out.puts(0x90+channel-1,note,velocity)
	end

	#Release a note. Does not require a duration. Is called when a release signal is received.
	def note_rlse(channel,note)
		@out.puts(0x80+channel-1,note,0x00)
	end

end

class NoteSender
	attr_reader :note, :chan, :vel
	def initialize(note,chan,vel,mute)
		@note = note
		@chan = chan
		@vel  = vel
		@mute = mute
	end
	
	def play
		Pm.note_send(@chan,@note,@vel) unless @mute
	end
	def stop
		Pm.note_rlse(@chan,@note) unless @mute
	end

end

Pm = Proc_Midi.new(0,0)