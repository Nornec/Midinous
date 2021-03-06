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

class GtkRadioButtonEx < Gtk::RadioButton
	type_register
	def initialize
		super()
	end
	define_signal('keybinding-event',nil,nil,nil)
end
class GtkButtonEx < Gtk::Button
	type_register
	def initialize
		super()
	end
	define_signal('keybinding-event',nil,nil,nil)
end
class GtkCanvas < Gtk::DrawingArea
	type_register
	def initialize
		super()
	end
	define_signal('delete-selected',nil,nil,nil)
	define_signal('mute-toggle',nil,nil,nil)
	define_signal('beat-up',nil,nil,nil)
	define_signal('beat-dn',nil,nil,nil)
	define_signal('beat-note-up',nil,nil,nil)
	define_signal('beat-note-dn',nil,nil,nil)
	define_signal('travel-event',nil,nil,nil)
	define_signal('cycle-play-mode-bck',nil,nil,nil)
	define_signal('cycle-play-mode-fwd',nil,nil,nil)
	define_signal('set-start',nil,nil,nil)
	define_signal('del-path-to',nil,nil,nil)
	define_signal('del-path-from',nil,nil,nil)
	define_signal('set-path-mode-h',nil,nil,nil)
	define_signal('set-path-mode-v',nil,nil,nil)
	define_signal('note-inc-up',nil,nil,nil)
	define_signal('note-inc-dn',nil,nil,nil)
	define_signal('path-rotate-bck',nil,nil,nil)
	define_signal('path-rotate-fwd',nil,nil,nil)
end
class GtkPropEntry < Gtk::Entry
	type_register
	def initialize
		super()
	end
	define_signal('keybinding-event',nil,nil,nil)
end

class UI_Elements
	include Logic_Controls
	# Construct a Gtk::Builder instance and load our UI description
	attr_reader :menu_commands,:canvas_commands,:in_device_items,
	            :out_device_items,:in_channel_items
	def initialize
		@current_file   = nil
		@operation_file = nil
		@current_window = nil
		@scale_iters      = []
		@in_channel_items = []
		@in_device_items  = []
		@out_device_items = []
	end
	def build_ui
		builder_file = "#{File.dirname(__FILE__)}/midinous.glade"
		
		# Connect signal handlers to the constructed widgets
		@builder = Gtk::Builder.new(:file => builder_file)
		
		#Windows
		def midinous 
			@builder.get_object("midinous")
		end
		def file_chooser
			@builder.get_object("file_chooser")
		end
		def confirmer
			@builder.get_object("confirmer")
		end
		def about_window
			@builder.get_object("about_window")
		end
		def notes_window
			@builder.get_object("notes_window")
		end
		def scales_window
			@builder.get_object("scales_window")
		end
		def hotkeys_window
			@builder.get_object("hotkeys_window")
		end
		
		#Menus
		def edit_menu
			@builder.get_object("edit_menu")
		end
		def input_menu
			@builder.get_object("input_menu")
		end
		def output_menu
			@builder.get_object("output_menu")
		end
		def input_channel_menu
			@builder.get_object("input_channel_menu")
		end
		def help_menu
			@builder.get_object("help_menu")
		end
		
		#Menu Items
		def file_new
			@builder.get_object("file_new")
		end
		def file_open
			@builder.get_object("file_open")
		end
		def file_save
			@builder.get_object("file_save")
		end
		def file_save_as
			@builder.get_object("file_save_as")
		end
		def file_quit
			@builder.get_object("file_quit")
		end
		def edit_io
			@builder.get_object("edit_io")
		end
		def help_about
			@builder.get_object("help_about")
		end		
		def help_notes
			@builder.get_object("help_notes")
		end		
		def help_scales
			@builder.get_object("help_scales")
		end		
		def help_hotkeys
			@builder.get_object("help_hotkeys")
		end
		
		#Drawing Areas
		def canvas
			@builder.get_object("canvas")
		end
		def canvas_viewport
			@builder.get_object("canvas_viewport")
		end
		def canvas_scroll_window
			@builder.get_object("canvas_scroll_window")
		end
		
		#Adjustments
		def canvas_h_adj
			@builder.get_object("canvas_scroll_h")
		end
		def canvas_v_adj
			@builder.get_object("canvas_scroll_v")
		end
		def tempo_adj
			@builder.get_object("tempo_adj")
		end
		def root_adj
			@builder.get_object("root_adj")
		end
		
		#Buttons
		def main_tool_1
			@builder.get_object("main_tool_1")
		end		
		def main_tool_2
			@builder.get_object("main_tool_2")
		end		
		def main_tool_3
			@builder.get_object("main_tool_3")
		end		
		def main_tool_4
			@builder.get_object("main_tool_4")
		end
		def path_builder
			@builder.get_object("path_builder")
		end
		def prop_mod_button
			@builder.get_object("prop_mod_button")
		end
		def play
			@builder.get_object("play")
		end
		def stop
			@builder.get_object("stop")
		end
		def tempo
			@builder.get_object("tempo")
		end
		def root_select
			@builder.get_object("root_select")
		end
		def file_operation
			@builder.get_object("file_operation")
		end
		def file_cancel
			@builder.get_object("file_cancel")
		end
		def confirmer_confirm
			@builder.get_object("confirmer_confirm")
		end
		def confirmer_cancel
			@builder.get_object("confirmer_cancel")
		end
		
		#Button Areas
		def logic_controls
			@builder.get_object("logic_controls")
		end
		
		#Text Areas
		def tool_descrip
			@builder.get_object("tool_descrip")
		end
		def status_area
			@builder.get_object("status_area")
		end
		def prop_mod
			@builder.get_object("prop_mod")
		end
		def t_sig
			@builder.get_object("t_sig")
		end
		def file_name
			@builder.get_object("file_name")
		end
		
		#Labels
		def perf_label
			@builder.get_object("perf_label")
		end		
		def tool_label
			@builder.get_object("tool_label")
		end
		def tempo_label
			@builder.get_object("tempo_label")
		end
		def property_label
			@builder.get_object("property_label")
		end		
		def modify_label
			@builder.get_object("modify_label")
		end
		def t_sig_label
			@builder.get_object("t_sig_label")
		end
		def confirmer_label
			@builder.get_object("confirmer_label")
		end
		def scale_label
			@builder.get_object("scale_label")
		end
		
		#Point Property Tree
		def prop_list_model
			@builder.get_object("prop_list_model")
		end	
		def prop_list_view
			@builder.get_object("prop_list_view")
		end
		def prop_list
			@builder.get_object("prop_list")
		end
		def prop_list_col1_h
			@builder.get_object("prop_list_col1_h")
		end
		def prop_list_col2_h
			@builder.get_object("prop_list_col2_h")
		end	
		def prop_list_col1
			@builder.get_object("prop_list_col1")
		end
		def prop_list_col2
			@builder.get_object("prop_list_col2")
		end
		def prop_list_selection
			@builder.get_object("prop_list_selection")
		end
		
		#Scale Selection Combo Box
		def scale_combo
			@builder.get_object("scale_combo")
		end
		def scale_tree_model
			@builder.get_object("scale_tree_model")
		end
		def scale_display
			@builder.get_object("scale_display")
		end
		def clear_io_menu_items
			@in_channel_items.each {|i| input_channel_menu.remove(i)}
			@in_channel_items = []
			@in_device_items.each {|i| input_menu.remove(i)}
			@in_device_items = []
			@out_device_items.each {|o| output_menu.remove(o)}
			@out_device_items = []
		end
		def set_io_menu_items
			unless Pm.in_list.length <= 1
				16.times.with_index {|i| @in_channel_items << Gtk::ImageMenuItem.new(label: (i+1).to_s)}
				@in_channel_items.each {|i| input_channel_menu.append(i)}
	
				Pm.in_list.each  {|i| @in_device_items << Gtk::ImageMenuItem.new(label: i.name)}
				@in_device_items.each  {|i| input_menu.append(i)}
			end
			Pm.out_list.each {|o| @out_device_items << Gtk::ImageMenuItem.new(label: o.name)}
			@out_device_items.each {|o| output_menu.append(o)}
			
			input_channel_menu.show_all
			input_menu.show_all
			output_menu.show_all
		end
		
		def set_device(id,type)
			case type
			when 'i'
				Pm.sel_in(id)
			when 'o'
				Pm.sel_out(id)
			end
			regen_status
		end

		def regen_status
			unless Pm.in_list.length <= 1
				status_area.text = "Using: Output[#{Pm.out_list[Pm.out_id].name}] "\
				"Input[#{Pm.in_list[Pm.in_id].name} Channel: #{Pm.in_chan}]"
			else
				status_area.text = "Using: Output[#{Pm.out_list[Pm.out_id].name}]"
			end
		end
		
		#Set up accelerators (keyboard shortcuts)
		@menu_commands = Gtk::AccelGroup.new
		@canvas_commands = Gtk::AccelGroup.new
		midinous.add_accel_group(@menu_commands)
		midinous.add_accel_group(@canvas_commands)
		
		scale_cat_1 = scale_tree_model.append(nil)
			scale_cat_1_sub_01 = scale_tree_model.append(scale_cat_1)
			scale_cat_1_sub_02 = scale_tree_model.append(scale_cat_1)
			scale_cat_1_sub_03 = scale_tree_model.append(scale_cat_1)
			scale_cat_1_sub_04 = scale_tree_model.append(scale_cat_1)
			scale_cat_1_sub_05 = scale_tree_model.append(scale_cat_1)
			scale_cat_1_sub_06 = scale_tree_model.append(scale_cat_1)
		scale_cat_2  = scale_tree_model.append(nil)
			scale_cat_2_sub_01 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_02 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_03 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_04 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_05 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_06 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_07 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_08 = scale_tree_model.append(scale_cat_2)		
			scale_cat_2_sub_09 = scale_tree_model.append(scale_cat_2)		
		scale_cat_3 = scale_tree_model.append(nil)
			scale_cat_3_sub_01 = scale_tree_model.append(scale_cat_3)
			scale_cat_3_sub_02 = scale_tree_model.append(scale_cat_3)
			scale_cat_3_sub_03 = scale_tree_model.append(scale_cat_3)
			scale_cat_3_sub_04 = scale_tree_model.append(scale_cat_3)
			scale_cat_3_sub_05 = scale_tree_model.append(scale_cat_3)
			scale_cat_3_sub_06 = scale_tree_model.append(scale_cat_3)		
		scale_cat_4 = scale_tree_model.append(nil)
			scale_cat_4_sub_01 = scale_tree_model.append(scale_cat_4)
			scale_cat_4_sub_02 = scale_tree_model.append(scale_cat_4)
			scale_cat_4_sub_03 = scale_tree_model.append(scale_cat_4)
			scale_cat_4_sub_04 = scale_tree_model.append(scale_cat_4)
			scale_cat_4_sub_05 = scale_tree_model.append(scale_cat_4)
			scale_cat_4_sub_06 = scale_tree_model.append(scale_cat_4)
		scale_cat_5 = scale_tree_model.append(nil)
			scale_cat_5_sub_01 = scale_tree_model.append(scale_cat_5)
			scale_cat_5_sub_02 = scale_tree_model.append(scale_cat_5)
			scale_cat_5_sub_03 = scale_tree_model.append(scale_cat_5)
			scale_cat_5_sub_04 = scale_tree_model.append(scale_cat_5)
			scale_cat_5_sub_05 = scale_tree_model.append(scale_cat_5)

		scale_cat_1 [0] = "Pentatonic"
				scale_cat_1_sub_01[0] = "Hirajoshi"           
				scale_cat_1_sub_02[0] = "Insen"               
				scale_cat_1_sub_03[0] = "Iwato"               
				scale_cat_1_sub_04[0] = "Pentatonic Major"    
				scale_cat_1_sub_05[0] = "Pentatonic Minor"    
				scale_cat_1_sub_06[0] = "Two Semitone Tritone"
		scale_cat_2 [0] = "Traditional"
				scale_cat_2_sub_01[0] = "Aeolian"         
				scale_cat_2_sub_02[0] = "Dorian"          
				scale_cat_2_sub_03[0] = "Harmonic Major"  
				scale_cat_2_sub_04[0] = "Harmonic Minor"  
				scale_cat_2_sub_05[0] = "Ionian"          
				scale_cat_2_sub_06[0] = "Locrian"         
				scale_cat_2_sub_07[0] = "Lydian"          
				scale_cat_2_sub_08[0] = "Mixolydian"      
				scale_cat_2_sub_09[0] = "Phrygian"
		scale_cat_3 [0] = "Modified Traditional"
				scale_cat_3_sub_01[0] =	"Altered"         			
				scale_cat_3_sub_02[0] =	"Half Diminished" 			
				scale_cat_3_sub_03[0] =	"Locrian Major"   			
				scale_cat_3_sub_04[0] =	"Lydian Augmented"			
				scale_cat_3_sub_05[0] =	"Melodic Minor"   			
				scale_cat_3_sub_06[0] =	"Ukrainian Dorian"			
		scale_cat_4 [0] = "Exotic"
				scale_cat_4_sub_01[0] = "Augmented" 
				scale_cat_4_sub_02[0] = "Blues"  
				scale_cat_4_sub_03[0] = "Flamenco"  
				scale_cat_4_sub_04[0] = "Hungarian" 
				scale_cat_4_sub_05[0] = "Persian"   
				scale_cat_4_sub_06[0] = "Prometheus"
		scale_cat_5 [0] = "Mathematical"
				scale_cat_5_sub_01[0] = "Chromatic"
				scale_cat_5_sub_02[0] = "Octatonic Whole"
				scale_cat_5_sub_03[0] = "Octatonic Half" 
				scale_cat_5_sub_04[0] = "Tritone" 
				scale_cat_5_sub_05[0] = "Whole Tone"
		
		@scale_iters << scale_cat_1_sub_01
		@scale_iters << scale_cat_1_sub_02
		@scale_iters << scale_cat_1_sub_03
		@scale_iters << scale_cat_1_sub_04
		@scale_iters << scale_cat_1_sub_05
		@scale_iters << scale_cat_1_sub_06
		@scale_iters << scale_cat_2_sub_01
		@scale_iters << scale_cat_2_sub_02
		@scale_iters << scale_cat_2_sub_03
		@scale_iters << scale_cat_2_sub_04
		@scale_iters << scale_cat_2_sub_05
		@scale_iters << scale_cat_2_sub_06
		@scale_iters << scale_cat_2_sub_07
		@scale_iters << scale_cat_2_sub_08
		@scale_iters << scale_cat_2_sub_09
		@scale_iters << scale_cat_3_sub_01
		@scale_iters << scale_cat_3_sub_02
		@scale_iters << scale_cat_3_sub_03
		@scale_iters << scale_cat_3_sub_04
		@scale_iters << scale_cat_3_sub_05
		@scale_iters << scale_cat_3_sub_06
		@scale_iters << scale_cat_4_sub_01
		@scale_iters << scale_cat_4_sub_02
		@scale_iters << scale_cat_4_sub_03
		@scale_iters << scale_cat_4_sub_04
		@scale_iters << scale_cat_4_sub_05
		@scale_iters << scale_cat_4_sub_06
		@scale_iters << scale_cat_5_sub_01
		@scale_iters << scale_cat_5_sub_02
		@scale_iters << scale_cat_5_sub_03
		@scale_iters << scale_cat_5_sub_04
		@scale_iters << scale_cat_5_sub_05

		scale_combo.active = 4
		scale_combo.active_iter = scale_cat_5_sub_01
		
		#Initialize the elements of the screen
		midinous.add_events("key-press-mask")
		canvas.add_events("button-press-mask")
		canvas.add_events("button-release-mask")
		canvas.add_events("pointer-motion-mask")
		prop_mod.add_events("key-press-mask")
		
		path_builder.sensitive = false
		prop_mod_button.sensitive = false
		stop.sensitive = false
		
		tool_descrip.text  = "Select"
		t_sig.text = "4/4"
		
		perf_label.markup       = "<b>#{perf_label.text}</b>"
		tempo_label.markup      = "<b>#{tempo_label.text}</b>"
		tool_label.markup       = "<b>#{tool_label.text}</b>"
		property_label.markup   = "<b>#{property_label.text}</b>"
		modify_label.markup     = "<b>#{modify_label.text}</b>"
		t_sig_label.markup      = "<b>#{t_sig_label.text}</b>"
		scale_label.markup      = "<b>#{scale_label.text}</b>"
		
		set_io_menu_items
		regen_status
		
		
		#canvas.add_events(Gdk::EventMask::BUTTON_PRESS_MASK.nick) #This points to a nickname, basically a string like "button-press-mask" in this case

		#Accel groups, parameter 2 is the modifier
		# 0 - no modifier
		# 1 - shift
		# 2 - no modifier?
		# 3 - shift again?
		# 4 - Cntl
		# 5 - Cntl+Shift
		
		file_chooser.filter = Gtk::FileFilter.new
		file_chooser.filter.add_pattern("*.nous")
		file_chooser.filter.name = "nous file filter"
	end
	def confirm(type)
		case type
		when "new"
			@current_window = "new_confirm"
			confirmer_confirm.label = "Create New"
			confirmer_label.markup = "<b> There are unsaved changes.</b> \n Do you wish to proceed? "
			confirmer_cancel.visible = true
		when "quit"
			@current_window = "quit_confirm"
			confirmer_confirm.label = "Quit"
			confirmer_cancel.visible = true
			confirmer_label.markup = "<b> There are unsaved changes.</b> \n Do you wish to proceed? "
		when "path_warning"
			@current_window = "path_warning"
			confirmer_confirm.label = "OK"
			confirmer_cancel.visible = false
			confirmer_label.markup = "<b> WARNING:</b> Live composition detected. \n This may have affected round-robin point starting paths. "
		end
		confirmer.visible = true
	end
	def file_input_check(type)
		case type
		when "chooser"
			unless UI::file_chooser.uri == nil
				UI::file_name.text = UI::file_chooser.uri.split("/").last
			else
				UI::file_name.text = ""
			end
		when "name"
			unless UI::file_name.text != "" || 
			       UI::file_chooser.uri != nil || 
						 UI::file_name.text.count(".") > 1
			then
					 UI::file_operation.sensitive = false 
			else UI::file_operation.sensitive = true 
			end
		end
	end
	def file_oper(type)
		case type
		when "open"
			@current_window = "file_open"
			file_chooser.title = "Open"
			file_operation.label = "Open"
			file_chooser.visible = true
			file_name.editable = false
		when "save"
			@current_window = "file_save"
			if @current_file == nil	#If the working file does not exist yet
				file_chooser.title = "Save As"
				file_operation.label = "Save As"
				file_name.editable = true
				file_chooser.visible = true
			else	
				save_operation #Resave the file if @current_file already exists
			end
		when "saveas"
			@current_window = "file_save"
			#If the working file does not exist yet, suggest a name
			file_name.text = @current_file.split("\\").last unless @current_file == nil
			file_chooser.title = "Save As"
			file_operation.label = "Save As"
			file_name.editable = true
			file_chooser.visible = true
		end
	end
	def confirm_act(choice)
		if choice == "yes"
			case @current_window
			when "new_confirm"
				CC.nouspoints.each do |n|
					n.traveler_start = false
					n.path_to   = []
					n.path_from = []
				end
				CC.nouspoints = []
				file_name.text = ""
				CC.tempo     = 120
				CC.scale     = "Chromatic"
				CC.root_note = 60
				CC.beats     = 4
				CC.beat_note = 4

				CC.set_tempo(CC.tempo)
				CC.set_scale(CC.scale,CC.root_note)
				CC.canvas_grid_change(nil)
				tempo_adj.value = CC.tempo
				@scale_iters.each {|s| scale_combo.active_iter = s if s[0] == CC.scale}
				root_adj.value  = CC.root_note
				@current_file = nil
				midinous.title = "Midinous"
			when "quit_confirm"
				Gtk.main_quit
			end
		end
		confirmer.visible = false
		canvas.queue_draw
	end
	def file_oper_act(choice)
		if choice == "yes"
			case @current_window
			when "file_open"
				#Remove current points and load points from file
				load_operation
			when "file_save"
				#Save nouspoints to a new, or existing file, window only if new
				save_operation
			end
		end
		file_chooser.visible = false
		canvas.queue_draw
	end
	
	def save_operation

		unless file_name.text[-5..-1] == ".nous"
			@current_file = "#{file_chooser.current_folder_uri}/#{file_name.text}.nous"
			
		else @current_file = "#{file_chooser.current_folder_uri}/#{file_name.text}"
		end
		
		operator = @current_file.sub("file:///","")
		operator = operator.gsub("/","\\")
		operator = operator.gsub("%20"," ")

		IO.binwrite(operator, "")
		save = File.open(operator, "a")
		issued_id = 0
		CC.nouspoints.each do |n|
			n.save_id = issued_id
			issued_id += 1
		end
		CC.nouspoints.each do |n|
			n.write_props(save)
			save.write("\n")
		end
		save.write("#{CC.tempo}<~>")
		save.write("#{CC.scale}<~>")
		save.write("#{CC.root_note}<~>")
		save.write("#{CC.beats}<~>")
		save.write("#{CC.beat_note}")
		midinous.title = "Midinous - #{operator}"
		save.close
	end
	def load_operation
		CC.canvas_stop
		CC.nouspoints = []
		@current_file = file_chooser.uri
		operator = @current_file.sub("file:///","")
		operator = operator.gsub("/","\\")
		operator = operator.gsub("%20"," ")
		
		load = IO.binread(operator)
		load = load.gsub("\r","")
		load = load.split("\n")
		load[0..-2].each do |point_line|
			point_line = point_line.split("<~>")
			CC.nouspoints << NousPoint.new(eval(point_line[1]),point_line[0].to_i)
		end
		CC.nouspoints.each do |n|
			load.each do |point_line|
				point_line = point_line.split("<~>")
				if point_line[0].to_i == n.save_id
					if point_line[2].match(/^([+]|-)[0-9]{1,2}$/)
						n.note = point_line[2]
						n.use_rel = true
					elsif (point_line[2].to_i >= 0 &&
					       point_line[2].to_i <= 127 &&
								!(point_line[2].include?("+") || point_line[2].include?("-")))
					then
						n.note = point_line[2].to_i
					end
					n.velocity       = point_line[3].to_i
					n.channel        = point_line[4].to_i
					n.duration       = point_line[5].to_i
					n.set_default_color(hex_to_color(point_line[6]))
					n.repeat         = point_line[7].to_i
					n.play_modes     = eval(point_line[8])
					n.traveler_start = eval(point_line[9])
					n.use_rel        = eval(point_line[10])
					n.path_mode      = point_line[11]
					n.mute           = eval(point_line[12])
					n.path_to_rels   = eval(point_line[13])
					n.path_from_rels = eval(point_line[14])
					n.path_to_rels.each   {|ptr| n.path_to   << CC.nouspoints.find {|f| ptr == f.save_id}}
					n.path_from_rels.each {|pfr| n.path_from << CC.nouspoints.find {|f| pfr == f.save_id}}
				end
			end
		end
		load_last = load.last.split("<~>")
		CC.tempo     = load_last[0].to_f
		CC.scale     = load_last[1]
		CC.root_note = load_last[2].to_i
		CC.beats     = load_last[3].to_i
		CC.beat_note = load_last[4].to_i
		
		CC.set_tempo(CC.tempo)
		CC.set_scale(CC.scale,CC.root_note)
		CC.canvas_grid_change(nil)
		tempo_adj.value = CC.tempo
		@scale_iters.each {|s| scale_combo.active_iter = s if s[0] == CC.scale}
		root_adj.value  = CC.root_note

		midinous.title = "Midinous - #{operator}"
	end
end

class Tool
	attr_reader :tool_id
	def initialize
		@tool_id = 1
	end
	def set_tool(id)
		@tool_id = id
		unless @tool_id == 4 
			UI::path_builder.sensitive = false
		end
		case
			when @tool_id == 1
				UI::main_tool_1.active = true
				UI::tool_descrip.text = "Select"
				UI::canvas.queue_draw
			when @tool_id == 2 
				UI::main_tool_2.active = true
				UI::tool_descrip.text = "Place"
				UI::canvas.queue_draw
			when @tool_id == 3 
				UI::main_tool_3.active = true 
				UI::tool_descrip.text = "Move"
				UI::canvas.queue_draw
			when @tool_id == 4 
				UI::main_tool_4.active = true
				UI::path_builder.sensitive = true
				UI::tool_descrip.text = "Path"
				UI::canvas.queue_draw
		end
	end

end

UI = UI_Elements.new()  #Create a new UI_Elements object
UI::build_ui
Active_Tool = Tool.new