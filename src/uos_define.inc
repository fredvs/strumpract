{ United Openlibraries of Sound (uos)
  License : modified LGPL.
  Fred van Stappen fiens@hotmail.com }

// Compiler definition

{.$DEFINE debug} // uncomment for debugging. For console applications. (Could not work with LCL nor GUI Windows).

{.$DEFINE consoleapp} // if FPC version < 2.7.1 uncomment for console application
{.$DEFINE library}   // uncomment for building uos library (native and java)
{.$DEFINE java}   // uncomment for building uos java library
{.$DEFINE fpgui}   // uncomment if FPC version < 2.7.1 and using fpGUI widget
{$DEFINE mse}   // uncomment when using a mse project, msethreads and msetimers. 
                // NOT YET for aarch64, use fpc threads insteed.
{.$DEFINE usequeue}   // uncomment to use Thread.Queue instead of Thread.Synchronize for fpc threads.

{$DEFINE portaudio} // uncomment to enable portaudio In/Out sound port
{$DEFINE sndfile} // uncomment to enable sndfile (wav, ogg, flac audio file)
{$DEFINE mpg123} // uncomment to enable mpg123 (mp3 audio file)
{$DEFINE xmp} // uncomment to enable xmp (mod, it, sp3 audio file)
{.$DEFINE neaac} // uncomment to enable neaac (m4a audio file)
{.$DEFINE opus} // uncomment to enable opus (opus audio file)
{.$DEFINE cdrom} // uncomment to enable cdrom audio decoder (cda)

{$DEFINE soundtouch} // uncomment to enable Soundtouch tempo/detect bpm plugin
{.$DEFINE bs2b} // uncomment to enable bs2b stereo to binaural plugin

{.$DEFINE webstream} // uncomment to enable Internet Audio Streaming

{.$DEFINE shout} // uncomment to enable IceCast-Shout audio web server.

{.$DEFINE noiseremoval} // uncomment to enable Noise Removal DSP

{.$DEFINE synthesizer} // uncomment to enable Synthesizer

