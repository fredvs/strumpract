
unit captionstrumpract;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msestockobjects,
  mseglob,
  msestrings,
  mseapplication,
  msetypes;

type
  randomnotefoty = (
      ra_randomnotefo, {'Chord Randomizer'}
      ra_timage8_hint, {'Click to listen to the guitar chord'}
      ra_keyb1_hint, {'Click to listen to piano chord'}
      ra_chord1drop_hint, {'Select a chord'}
      ra_tbutton4_hint, {'Close all StrumPract (Click the icon in corner of the form to close only Randomizer)'}
      ra_bnbchords_hint, {'Randomize chords'}
      ra_bnbchords, {'Randomize'}
      ra_btnfixed_hint, {'Manual fixed chords'}
      ra_btnfixed, {'Fixed'}
      ra_tbutton5_hint, {' Tuned guitar string '}
      ra_tbutton5, {'Tuned Guitars'}
      ra_bchord1_hint, {'Re-do a randomizer for chord 1'}
      ra_tbutton2_hint, {'Clear chords'}
      ra_tgroupbox1frame, {'Chords'}
      ra_bool7th,
      ra_bool7th_hint, {'Enable 7th Chords'}
      ra_boolminorframe, {' minor'}
      ra_boolminor_hint, {'Enable minor Chords'}
      ra_boolmajorframe, {' Major'}
      ra_boolmajor_hint, {'Enable Major Chords'}
      ra_bool9thframe, {' 9th'}
      ra_bool9th_hint, {'Enable 9th Chords'}
      ra_withsharpframe, {' # (Sharp)'}
      ra_withsharp_hint, {'Enable Sharp-Chords #'}
      ra_bosoundframe, {' Sound'}
      ra_bosound_hint, {'Enable Sound of Chords'}
      ra_tgroupbox2frame, {'Number'}
      ra_numchord_hint, {'Total chords'}
      ra_maxnote_hint, {'Maximum number of chords'}
      ra_withrandomframe, {' Random num'}
      ra_withrandom_hint, {'Randomize the number of chords'}
      ra_bpm_hint, {'Tempo of Drums in BPM'}
      ra_nodrumsframe, {' Enable Drums'}
      ra_nodrums_hint, {'Enable random Drums tempo'}
      ra_bconfig_hint {'Configure the "Clear" message'}
     );

type
  drumsfoty = (
      dr_labd, {'Bass'}
      dr_lasd, {'Snare'}
      dr_laoh, {'Open H'}
      dr_lach, {'Close H'}
      dr_labpat, {'Patern 1'}
      dr_tbooleaneditradio8_hint, {' Drums Patern 1 '}
      dr_tbooleaneditradio7_hint, {' Drums Patern 2 '}
      dr_tbooleaneditradio6_hint, {' Drums Patern 3 '}
      dr_tbooleaneditradio5_hint, {' Drums Patern 4 '}
      dr_lesson4_hint,
      dr_lesson3_hint,
      dr_lesson2_hint,
      dr_lesson1_hint,
      dr_tlabel22, {'Patern'}
      dr_tlabel21, {'Lesson'}
      dr_noanim, {'no anim'}
      dr_noanim_hint, {' No graphic animation. '}
      dr_noand, {'no and"'}
      dr_noand_hint, {' No "and" between 2 numbers. '}
      dr_novoice, {'no voice'}
      dr_novoice_hint, {' No counting voice '}
      dr_nodrums, {'no drums'}
      dr_nodrums_hint, {' No drums sound.  '}
      dr_loop_stop_hint, {' Stop loop '}
      dr_loop_resume_hint, {' Resume loop '}
      dr_loop_start_hint, {' Start loop '}
      dr_edittempo_hint, {'BPM (Beats per minut)'}
      dr_tlabel23, {'Volume'}
      dr_volumedrums_hint, {' General volume of Drums '}
      dr_ltempo_hint, {' Beats per minuts - interval in 1/10000 second. '}
      dr_multbpm_hint, {' Set BPM X 2 '}
      dr_divbpm_hint, {' Set BPM / 2 '}
      dr_langcount, {'Lang'}
      dr_langcount_hint {'Language for counting'}
      
   );
  
type
  spectrum1foty = (
      sp_spectrum1fodragdock, {' Spect '}
      sp_spectrum1fo, {'Spectrum'}
      sp_tchartright_hint, {' Right Frequency spectrum '}
      sp_tchartleft_hint, {' Left Frequency spectrum '}
      sp_tstringdisp2_hint  {'Enable Spectrum'}
     );
  
type
  equalizerfoty = (
      eq_groupbox2frame, {'right '}
      eq_tbutton11_hint, {' Reset to 0 gain '}
      eq_loadset_hint, {' Load a Settings file  '}
      eq_saveset_hint, {' Save Settings in a file '}
      eq_groupbox1frame, {'left'}
      eq_tstringdisp21_hint {'Ebable Equalizer'}
   );  
  
type
  infosfoty = (
      in_infosfo, {'Infos of song'}
      in_tlabel2, {'No Image Tag'}
      in_infonameframe, {'Title'}
      in_infoartistframe, {'Artist'}
      in_infoalbumframe, {'Album'}
      in_infoyearframe, {'Year'}
      in_infolengthframe, {'Duration'}
      in_infotagframe, {'Genre'}
      in_tracktagframe, {'Track'}
      in_infocomframe, {'Comment'}
      in_infofileframe, {'File Name'}
      in_inforateframe, {'Rate'}
      in_infochanframe, {'Chan'}
      in_infobpmframe {'BMP'}
      
   );  
  
  
 type
  mainfoty = (
      ma_mainfo, {'StrumPract'}
      ma_basedockdragdock, {'Dock any window on this area.'}
      ma_basedockdockingarea, {'Drag a form here using right-border grip.'}

      ma_tmainmenu1_dock, {'&Dock'}
      ma_tmainmenu1_dock_hint, {'Dock windows in one form'}

      ma_tmainmenu1_tab, {'&Tab'}
      ma_tmainmenu1_tab_hint, {'One form with tabs'}

      ma_tmainmenu1_parentitem_dockall, {'&Dock all visible windows'}
      
      ma_tmainmenu1_parentitem_floatall, {'&Float all visible windows'}
      ma_tmainmenu1_parentitem_floatall_hint, {'Float windows in independent forms'}

      ma_tmainmenu1_parentitem_taball, {'&Tab all visible windows'}
      ma_tmainmenu1_parentitem_taball_hint, {'Make windows tabed in one form'}

      ma_tmainmenu1_parentitem_jamsession, {'&Jam Session'}

      ma_tmainmenu1_parentitem_djwave, {'DJ Console Wave'}

      ma_tmainmenu1_parentitem_djinfo, {'DJ Console Info'}

      ma_tmainmenu1_parentitem_recordstage, {'&Record stage'}

      ma_tmainmenu1_parentitem_chordrandom, {'&Chords Randomizer'}

      ma_tmainmenu1_parentitem_imagedancer, {'&Image Dancer'}

      ma_tmainmenu1_parentitem_savelayout, {'Save Layout'}
      ma_tmainmenu1_parentitem_savelayout_hint, {'Save current layout'}

      ma_tmainmenu1_parentitem_loadlayout, {'Load Layout'}
      ma_tmainmenu1_parentitem_loadlayout_hint, {'Load saved layout'}

      ma_tmainmenu1_layout, {'&Layout'}
      ma_tmainmenu1_layout_hint, {'Layout of windows'}

      ma_tmainmenu1_parentitem_showall, {'Show All'}

      ma_tmainmenu1_parentitem_hideall, {'Hide All'}

      ma_tmainmenu1_panels, {'&Panels'}

      ma_tmainmenu1_show, {'Show'}
      ma_tmainmenu1_show_hint, {'Show/hide windows'}

      ma_tmainmenu1_parentitem_square, {'Square'}

      ma_tmainmenu1_parentitem_triangle, {'Triangle'}

      ma_tmainmenu1_parentitem_lines, {'Lines'}

      ma_tmainmenu1_parentitem_fractraltree, {'Fractal Tree'}

      ma_tmainmenu1_parentitem_superformula, {'Super Formula'}

      ma_tmainmenu1_parentitem_hyperformula, {'Hyper Formula'}

      ma_tmainmenu1_parentitem_atom, {'Atom'}

      ma_tmainmenu1_parentitem_spiralhue, {'Spiral Hue'}

      ma_tmainmenu1_parentitem_spiralrainbow, {'Spiral Rainbow'}

      ma_tmainmenu1_parentitem_spiralmove, {'Spiral Move'}

      ma_tmainmenu1_parentitem_turtle1, {'Turtle 1'}

      ma_tmainmenu1_parentitem_turtle2, {'Turtle 2'}

      ma_tmainmenu1_parentitem_fractalcircles, {'Fractal Circles'}

      ma_tmainmenu1_parentitem_normalform, {'Normal form'}
      ma_tmainmenu1_parentitem_normalform_hint, {'Use this form to set the size for Ellipse and (Round)Rectangle forms.'}

      ma_tmainmenu1_parentitem_ellipse, {'Ellipse'}

      ma_tmainmenu1_parentitem_roundrect, {'Rounded rect'}

      ma_tmainmenu1_parentitem_rect, {'Rectangle'}

      ma_tmainmenu1_parentitem_alwaystop, {'Always on top'}

      ma_tmainmenu1_parentitem_transparent, {'Transparent'}

      ma_tmainmenu1_parentitem_hidedancer, {'Hide Dancer'}

      ma_tmainmenu1_dancer, {'Da&ncer'}
      ma_tmainmenu1_dancer_hint, {'Dancing Animations'}

      ma_tmainmenu1_parentitem_gold, {'Gold'}

      ma_tmainmenu1_parentitem_silver, {'Silver'}

      ma_tmainmenu1_parentitem_carbon, {'Carbon'}

      ma_tmainmenu1_style, {'&Style'}
      ma_tmainmenu1_style_hint, {'Layout style Gold, Silver or Carbon'}

      ma_tmainmenu1_parentitem_audio, {'Audio'}
      ma_tmainmenu1_parentitem_audio_hint, {'Config of audio and colors'}

      ma_tmainmenu1_parentitem_language, {'Language'}
      ma_tmainmenu1_parentitem_language_hint, {'Set language'}

      ma_tmainmenu1_config, {'&Config'}
      ma_tmainmenu1_config_hint, {'Configuration setting'}

      ma_tmainmenu1_about, {'&About'}
      ma_tmainmenu1_about_hint, {'About StrumPract'}

      ma_tmainmenu1_quit, {'&Quit'}
      ma_tmainmenu1_quit_hint, {'Terminate StrumPract'}
      ma_setasdefault, {Set as default}
      ma_recorder, {Recorder}
      ma_hide,
      ma_fileslist, {Files list}
      ma_guitars, {Guitars}
      ma_waveform,
      ma_equalizer,
      ma_dockpanel
 
   );

type
  commanderfoty = (
      co_commanderfogriphint, {'Use that grip panel to drag/drop the window.'}
      co_commanderfodragdock, {'Com'}
      co_commanderfo, {'Commander'}
      co_loop_start_hint, {'Start Drums'}
      co_loop_stop_hint, {'Pause Drums'}
      co_loop_resume_hint, {'Resume Drums'}
      co_tslider2_hint, {'General Volume of drums'}
      co_namedrums_hint, {'Drums set'}
      co_tslider2val_hint, {'Click to switch to 100% <> 0% '}
      co_tslider3_hint, {'Volume of input (mic or input)'}
      co_nameinput_hint, {'Input (mic or aux in)'}
      co_butinput_hint, {'Enable Live Input'}
      co_genvolright_hint, {'Right Volume General in %'}
      co_genvolleft_hint, {'Left Volume General in %'}
      co_genleftvolvalue_hint, {'General left volume. Click to reset to 100%.'}
      co_genrightvolvalue_hint, {'General right volume. Click to reset to 100%.'}
      co_linkvol_hint, {'Lock left and right channels'}
      co_namegen_hint, {'General Volume in %'}
      co_sysvol_hint, {'System Master Volume'}
      co_timemix_hint, {'Change mixing time in 1/100 second'}
      co_btnStop_hint, {'Stop player'}
      co_btnStart_hint, {'Load and Start Player'}
      co_volumeleft1_hint, {'Left Volume Player 1'}
      co_volumeright1_hint, {'Right Volume Player 1'}
      co_tbutton2_hint, {'Start Player 1 --> MIX --> Stop Player 2'}
      co_tbutton3_hint, {'Start Player 2 --> MIX --> Stop Player 1'}
      co_volumeright2_hint, {'Right Volume Player 2'}
      co_volumeleft2_hint, {'Left Volume Player 2'}
      co_btncue_hint, {'Cue-Load-Pause Player'}
      co_btnPause_hint, {'Pause player'}
      co_tbutton5_hint, {'Pause Mixing'}
      co_speccalcb_hint, {'Enable Spectrum Frequencies Calculation'}
      co_guimixb_hint, {'Graphic-anim while mixing (if cpu too low set it off)'}
      co_vuinb_hint, {'View Meters on/off'}
      co_automixb_hint, {'Auto Mixing on/off'}
      co_directmixb_hint, {'Direct MIX (0 second time)'}
      co_nameplayers_hint, {'Player 1'}
      co_nameplayers2_hint, {'Player 2'}
      co_Brandommix_hint, {'Randomize mixing list'}
      co_hintlabel, {'Invalid value.  Reset to 100.'}
      co_hintlabel2 {'Or press Esc key for previous value.'}
      
   );
type
  filelistfoty = (
      fi_filelistfoframegriphint, {' Use this grip panel to drag/drop the window'}
      fi_filelistfodragdock, {'Files'}
      fi_filelistfo, {'Audio files'}
      fi_filescount_hint, {'Number of files in the list'}
      fi_tbutton11_hint, {'Find a word in list'}
      fi_tbutton1_hint, {'Sent selected song to cue for Player 1'}
      fi_tbutton2_hint, {'Sent selected song to cue for Player 2'}
      fi_list_files_hint, {'To move a row: click+hold into the fixed column and drag the row where you want.'}
      fi_list_files_name, {'Name of sound'}
      fi_list_files_ext, {'Ext'}
      fi_list_files_ext_hint, {'File extension'}
      fi_list_files_size, {'Size'}
      fi_list_files_size_hint, {'Size in Kb of the file'}
      fi_list_files_mix, {'Mix'}
      fi_list_files_mix_hint, {'Include for mix.  Clicking on the fixed cell ---> select all/none.'}
      fi_tbutton3_hint, {'Load custom play-list'}
      fi_tbutton3, {'Load'}
      fi_tbutton4_hint, {'Save custom play-list'}
      fi_tbutton5_hint, {'Add file in custom play-list'}
      fi_tbutton5, {'Add'}
      fi_historyfn_hint, {'History of Directories'}
      fi_tbutton6_hint {'Choose a audio directory with wav, ogg, flac or mp3'}
    
   );
   
   type
  songplayerfoty = (
      so_songplayerfodragdock, {Play'}
      so_edvolleft_hint, {' Change Left volume '}
      so_button1_hint, {' Reset to tempo original '}
      so_trackbar1_hint, {' Click to change position of sound '}
      so_historyfn_hint, {' History of Cue files '}
      so_edvolright_hint, {' Change Right volume '}
      so_edtempo_hint, {' Change tempo of song '}
      so_btinfos_hint, {' Show infos of the song '}
      so_btinfos, {'Info'}
      so_button2_hint, {' Detect BMP from current position and set it to Drums tempo. '}
      so_btnResume_hint, {' Resume player '}
      so_btnStart_hint, {' Load from cue and Start player '}
      so_BtnCue_hint, {' Load from cue and Pause player '}
      so_tbutton6_hint, {' Choose a  wav, ogg, flac or mp3 audio file '}
      so_lposition_hint, {' Position of sound '}
      so_llength_hint, {' Length of sound '}
      so_cbloopb_hint, {' Enable looping the song. (Pause is not enabled with loop.) '}
      so_setmono_hint, {'Set Mono/Stereo'}
      so_waveformcheck_hint, {' Show wave form in slider '}
      so_playreverse_hint, {' Enable playing reverse.'}
      so_cbtempo_hint {' Enable stretching (changing tempo) '}
       );
    
type
  randomnotefoaty = array [randomnotefoty] of msestring;
  drumsfoaty = array[drumsfoty] of msestring;
  spectrum1foaty = array[spectrum1foty] of msestring;
  equalizerfoaty = array[equalizerfoty] of msestring;
  songplayerfoaty  = array[songplayerfoty] of msestring;
  infosfoaty  = array[infosfoty] of msestring;
  mainfoaty  = array[mainfoty] of msestring;
  commanderfoaty  = array[commanderfoty] of msestring;
  filelistfoaty = array[filelistfoty] of msestring;
  
var
   lang_randomnotefo,
   lang_drumsfo,
   lang_spectrum1fo,
   lang_equalizerfo, lang_songplayerfo, lang_infosfo, lang_filelistfo,
   lang_mainfo, lang_commanderfo, lang_langnames: array of msestring; 
   
const
  en_filelistfotext: filelistfoaty = (
      'Use this grip panel to drag/drop the window', {fi_filelistfohint}
      'Files', {fi_filelistfo}
      'Audio files', {fi_filelistfo}
      'Number of files in the list', {fi_filescount_hint}
      'Find a word in list', {fi_tbutton11_hint}
      'Sent selected song to cue for Player 1', {fi_tbutton1_hint}
      'Sent selected song to cue for Player 2', {fi_tbutton2_hint}
      'To move a row: click+hold into the fixed column and drag the row where you want.', {fi_list_files_hint}
      'Name of sound', {fi_list_files}
      'Ext', {fi_list_files}
      'File extension', {fi_list_files_hint}
      'Size', {fi_list_files}
      'Size in Kb of the file', {fi_list_files_hint}
      'Mix', {fi_list_files}
      'Include for mix.  Clicking on the fixed cell ---> select all/none.', {fi_list_files_hint}
      'Load custom play-list', {fi_tbutton3_hint}
      'Load', {fi_tbutton3}
      'Save custom play-list', {fi_tbutton4_hint}
      'Add file in custom play-list', {fi_tbutton5_hint}
      'Add', {fi_tbutton5}
      'History of Directories', {fi_historyfn_hint}
      'Choose a audio directory with wav, ogg, flac or mp3' {fi_tbutton6_hint}
      );


const
  en_mainfotext: mainfoaty = (
      'StrumPract', {ma_mainfo}
      'Dock any window on this area.', {ma_basedock}
      'Drag a form here using right-border grip.', {ma_basedock}
      '&Dock', {ma_tmainmenu1_'dock'}
      'Dock windows in one form', {ma_tmainmenu1_'dock'_hint}
      '&Tab', {ma_tmainmenu1_'tab'}
      'One form with tabs', {ma_tmainmenu1_'tab'_hint}
      '&Dock all visible windows', {ma_tmainmenu1_parentitem_'dockall'}
      '&Float all visible windows', {ma_tmainmenu1_parentitem_'floatall'}
      'Float windows in independent forms', {ma_tmainmenu1_parentitem_'floatall'_hint}
      '&Tab all visible windows', {ma_tmainmenu1_parentitem_'taball'}
      'Make windows tabed in one form', {ma_tmainmenu1_parentitem_'taball'_hint}
      '&Jam Session', {ma_tmainmenu1_parentitem_'jamsession'}
      'DJ Console Wave', {ma_tmainmenu1_parentitem_'djwave'}
      'DJ Console Info', {ma_tmainmenu1_parentitem_'djinfo'}
      '&Record stage', {ma_tmainmenu1_parentitem_'recordstage'}
      '&Chords Randomizer', {ma_tmainmenu1_parentitem_'chordrandom'}
      '&Image Dancer', {ma_tmainmenu1_parentitem_'imagedancer'}
      'Save Layout', {ma_tmainmenu1_parentitem_'savelayout'}
      'Save current layout', {ma_tmainmenu1_parentitem_'savelayout'_hint}
      'Load Layout', {ma_tmainmenu1_parentitem_'loadlayout'}
      'Load saved layout', {ma_tmainmenu1_parentitem_'loadlayout'_hint}
      '&Layout', {ma_tmainmenu1_'layout'}
      'Layout of windows', {ma_tmainmenu1_'layout'_hint}
      'Show All', {ma_tmainmenu1_parentitem_'showall'}
      'Hide All', {ma_tmainmenu1_parentitem_'hideall'}
      'Panels', {ma_tmainmenu1_'panels'}
      'Show', {ma_tmainmenu1_'show'}
      'Show/hide windows', {ma_tmainmenu1_'show'_hint}
      'Square', {ma_tmainmenu1_parentitem_'square'}
      'Triangle', {ma_tmainmenu1_parentitem_'triangle'}
      'Lines', {ma_tmainmenu1_parentitem_'lines'}
      'Fractal Tree', {ma_tmainmenu1_parentitem_'fractraltree'}
      'Super Formula', {ma_tmainmenu1_parentitem_'superformula'}
      'Hyper Formula', {ma_tmainmenu1_parentitem_'hyperformula'}
      'Atom', {ma_tmainmenu1_parentitem_'atom'}
      'Spiral Hue', {ma_tmainmenu1_parentitem_'spiralhue'}
      'Spiral Rainbow', {ma_tmainmenu1_parentitem_'spiralrainbow'}
      'Spiral Move', {ma_tmainmenu1_parentitem_'spiralmove'}
      'Turtle 1', {ma_tmainmenu1_parentitem_'turtle1'}
      'Turtle 2', {ma_tmainmenu1_parentitem_'turtle2'}
      'Fractal Circles', {ma_tmainmenu1_parentitem_'fractalcircles'}
      'Normal form', {ma_tmainmenu1_parentitem_'normalform'}
      'Use this form to set the size for Ellipse and (Round)Rectangle forms.', {ma_tmainmenu1_parentitem_'normalform'_hint}
      'Ellipse', {ma_tmainmenu1_parentitem_'ellipse'}
      'Rounded rect', {ma_tmainmenu1_parentitem_'roundrect'}
      'Rectangle', {ma_tmainmenu1_parentitem_'rect'}
      'Always on top', {ma_tmainmenu1_parentitem_'alwaystop'}
      'Transparent', {ma_tmainmenu1_parentitem_'transparent'}
      'Hide Dancer', {ma_tmainmenu1_parentitem_'hidedancer'}
      'Da&ncer', {ma_tmainmenu1_'dancer'}
      'Dancing Animations', {ma_tmainmenu1_'dancer'_hint}
      'Gold', {ma_tmainmenu1_parentitem_'gold'}
      'Silver', {ma_tmainmenu1_parentitem_'silver'}
      'Carbon', {ma_tmainmenu1_parentitem_'carbon'}
      '&Style', {ma_tmainmenu1_'style'}
      'Layout style Gold, Silver or Carbon', {ma_tmainmenu1_'style'_hint}
      'Audio', {ma_tmainmenu1_parentitem_'audio'}
      'Config of audio and colors', {ma_tmainmenu1_parentitem_'audio'_hint}
      'Language', {ma_tmainmenu1_parentitem_'language'}
      'Set language', {ma_tmainmenu1_parentitem_'language'_hint}
      '&Config', {ma_tmainmenu1_'config'}
      'Configuration setting', {ma_tmainmenu1_'config'_hint}
      '&About', {ma_tmainmenu1_'about'}
      'About StrumPract', {ma_tmainmenu1_'about'_hint}
      '&Quit', {ma_tmainmenu1_'quit'}
      'Terminate StrumPract', {ma_tmainmenu1_'quit'_hint}
      'Set as default', {ma_setasdefault}
      'Recorder', {ma_recorder}
      'Hide',{ma_hide}
      'Files list', {ma_fileslist}
      'Guitars', {ma_guitars}
      'Wave form', {ma_waveform} 
      'Equalizer', {ma_equalizer}
      'Dock Panel' {ma_dockpanel}
    );
    
    const
  en_commanderfotext: commanderfoaty = (
      'Use that grip panel to drag/drop the window.', {co_commanderfo_hint}
      'Com', {co_commanderfo}
      'Commander', {co_commanderfo}
      'Start Drums', {co_loop_start_hint}
      'Pause Drums', {co_loop_stop_hint}
      'Resume Drums', {co_loop_resume_hint}
      'General Volume of drums', {co_tslider2_hint}
      'Drums', {co_namedrums_hint}
      'Click to switch to 100% <> 0% ', {co_tslider2val_hint}
      'Volume of input (mic or input)', {co_tslider3_hint}
      'Input (mic or aux in)', {co_nameinput_hint}
      'Enable Live Input', {co_butinput_hint}
      'Right Volume General in %', {co_genvolright_hint}
      'Left Volume General in %', {co_genvolleft_hint}
      'General left volume. Click to reset to 100%.', {co_genleftvolvalue_hint}
      'General right volume. Click to reset to 100%.', {co_genrightvolvalue_hint}
      'Lock left and right channels', {co_linkvol_hint}
      'General Volume in %', {co_namegen_hint}
      'System Master Volume', {co_sysvol_hint}
      'Change mixing time in 1/100 second', {co_timemix_hint}
      'Stop player', {co_btnStop_hint}
      'Load and Start Player', {co_btnStart_hint}
      'Left Volume Player 1', {co_volumeleft1_hint}
      'Right Volume Player 1', {co_volumeright1_hint}
      'Start Player 1 --> MIX --> Stop Player 2', {co_tbutton2_hint}
      'Start Player 2 --> MIX --> Stop Player 1', {co_tbutton3_hint}
      'Right Volume Player 2', {co_volumeright2_hint}
      'Left Volume Player 2', {co_volumeleft2_hint}
      'Cue-Load-Pause Player', {co_btncue_hint}
      'Pause player', {co_btnPause_hint}
      'Pause Mixing', {co_tbutton5_hint}
      'Enable Spectrum Frequencies Calculation', {co_speccalcb_hint}
      'Graphic-anim while mixing (if cpu too low set it off)', {co_guimixb_hint}
      'View Meters on/off', {co_vuinb_hint}
      'Auto Mixing on/off', {co_automixb_hint}
      'Direct MIX (0 second time)', {co_directmixb_hint}
      'Player 1', {co_nameplayers_hint}
      'Player 2', {co_nameplayers2_hint}
      'Randomize mixing list', {co_Brandommix_hint}
      'Invalid value.  Reset to 100.', {co_hintlabel}
      'Or press Esc key for previous value.' {co_hintlabel2}
      
   );
   
   const
  en_infosfotext: infosfoaty = (
      'Infos of song', {in_infosfo}
      'No Image Tag', {in_tlabel2}
      'Title', {in_infoname}
      'Artist', {in_infoartist}
      'Album', {in_infoalbum}
      'Year', {in_infoyear}
      'Duration', {in_infolength}
      'Genre', {in_infotag}
      'Track', {in_tracktag}
      'Comment', {in_infocom}
      'File Name', {in_infofile}
      'Rate', {in_inforate}
      'Chan', {in_infochan}
      'BPM' {in_infobpm}
      
   );
   
 const
  en_songplayerfotext: songplayerfoaty = (
     'Play1', {so_songplayerfo}
     'Change Left volume', {so_edvolleft_hint}
     'Reset to tempo original', {so_button1_hint}
     'Click to change position of sound', {so_trackbar1_hint}
     'History of Cue files', {so_historyfn_hint}
     'Change Right volume', {so_edvolright_hint}
     'Change tempo of song', {so_edtempo_hint}
     'Show infos of the song', {so_btinfos_hint}
     'Info', {so_btinfos}
     'Detect BMP from current position and set it to Drums tempo.', {so_button2_hint}
     'Resume player', {so_btnResume_hint}
     'Load from cue and Start player', {so_btnStart_hint}
     'Load from cue and Pause player', {so_BtnCue_hint}
     'Choose a  wav, ogg, flac or mp3 audio file', {so_tbutton6_hint}
     'Position of sound', {so_lposition_hint}
     'Length of sound', {so_llength_hint}
     'Enable looping the song. (Pause is not enabled with loop.)', {so_cbloopb_hint}
     'Set Mono/Stereo', {so_setmono_hint}
     'Show wave form in slider', {so_waveformcheck_hint}
     'Enable playing reverse.', {so_playreverse_hint}
     'Enable stretching (changing tempo)' {so_cbtempo_hint}
         
   );
   
   const
  en_equalizerfotext: equalizerfoaty = (
      'right', {eq_groupbox2}
      'Reset to 0 gain', {eq_tbutton11_hint}
      'Load a Settings file', {eq_loadset_hint}
      'Save Settings in a file', {eq_saveset_hint}
      'left', {eq_groupbox1}
      'Enable Equalizer' {eq_tstringdisp21_hint} 
    );
   
   en_spectrum1fotext: spectrum1foaty = (
      'Spect', {sp_spectrum1fo}
      'Spectrum', {sp_spectrum1fo}
      'Right Frequency spectrum', {sp_tchartright_hint}
      'Left Frequency spectrum', {sp_tchartleft_hint}
      'Enable Spectrum' {sp_tstringdisp2_hint}
    ); 
    
  const
  en_drumsfotext: drumsfoaty = (
      'Bass', {dr_labd}
      'Snare', {dr_lasd}
      'Open H', {dr_laoh}
      'Close H', {dr_lach}
      'Patern 1', {dr_labpat}
      'Drums Patern 1', {dr_tbooleaneditradio8_hint}
      'Drums Patern 2', {dr_tbooleaneditradio7_hint}
      'Drums Patern 3', {dr_tbooleaneditradio6_hint}
      'Drums Patern 4', {dr_tbooleaneditradio5_hint}
      'Last lesson. Do the same as 3th lesson but increasing the tempo. On count 2 you may add a boom on the Bass Drum. Congratulation, you are a drummer now.',
      '3th lesson Do the same as second lesson and on count 3 add a clack on the Snare Drum. This is the most difficult. Still count loud with your voice.', {dr_lesson3_hint}
      'Second lesson. Do the same as first lesson and on count 1 add a boom with your right foot on the Bass Drum. Still count loud with your voice.', {dr_lesson2_hint}
      'First lesson. With the stick hit the closed hat on each count. Count loud with your voice too.', {dr_lesson1_hint}
      'Patern', {dr_tlabel22}
      'Lesson', {dr_tlabel21}
      'no anim', {dr_noanim}
      'No graphic animation.', {dr_noanim_hint}
      'no and', {dr_noand}
      'No and between 2 numbers.', {dr_noand_hint}
      'no voice', {dr_novoice}
      'No counting voice', {dr_novoice_hint}
      'no drums', {dr_nodrums}
      'No drums sound.', {dr_nodrums_hint}
      'Stop loop', {dr_loop_stop_hint}
      'Resume loop', {dr_loop_resume_hint}
      'Start loop', {dr_loop_start_hint}
      'BPM (Beats per minut)', {dr_edittempo_hint} 
      'Volume', {dr_tlabel23}
      'General volume of Drums', {dr_volumedrums_hint}
      'Beats per minuts - interval in 1/10000 second.', {dr_ltempo_hint}
      'Set BPM X 2', {dr_multbpm_hint}
      'Set BPM / 2', {dr_divbpm_hint}
      'Lang', {dr_langcount}
      'Language for counting' {dr_langcount_hint}
      
   ); 
   
   
   const
  en_randomnotefotext: randomnotefoaty = (
      'Chord Randomizer', {ra_randomnotefo}
      'Click to listen to the guitar chord', {ra_timage8_hint}
      'Click to listen to piano chord', {ra_keyb1_hint}
      'Select a chord', {ra_chord1drop_hint}
      'Close all StrumPract (Click the icon in corner of the form to close only Randomizer)', {ra_tbutton4_hint}
      'Randomize chords', {ra_bnbchords_hint}
      'Randomize', {ra_bnbchords}
      'Manual fixed chords', {ra_btnfixed_hint}
      'Fixed', {ra_btnfixed}
      'Tuned guitar string', {ra_tbutton5_hint}
      'Tuned Guitars', {ra_tbutton5}
      'Re-do a randomizer', {ra_bchord1_hint}
      'Clear chords', {ra_tbutton2_hint}
      'Chords', {ra_tgroupbox1}
      '7th', {ra_bool7th}
      'Enable 7th Chords', {ra_bool7th_hint}
      'minor', {ra_boolminor}
      'Enable minor Chords', {ra_boolminor_hint}
      'Major', {ra_boolmajor}
      'Enable Major Chords', {ra_boolmajor_hint}
      '9th', {ra_bool9th}
      'Enable 9th Chords', {ra_bool9th_hint}
      '# (Sharp)', {ra_withsharp}
      'Enable Sharp-Chords #', {ra_withsharp_hint}
      'Sound', {ra_bosound}
      'Enable Sound of Chords', {ra_bosound_hint}
      'Number', {ra_tgroupbox2}
      'Total chords', {ra_numchord_hint}
      'Maximum number of chords', {ra_maxnote_hint}
      'Random num', {ra_withrandom}
      'Randomize the number of chords', {ra_withrandom_hint}
      'Tempo of Drums in BPM', {ra_bpm_hint}
      'Enable Drums', {ra_nodrums}
      'Enable random Drums tempo', {ra_nodrums_hint}
      'Configure the Clear message' {ra_bconfig_hint}
    
      );

implementation

uses
  SysUtils,
  msesysintf,
  msearrayutils,
  mseformatstr;

initialization

end.

