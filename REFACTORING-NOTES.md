# StrumPract — code-duplication refactoring notes

A duplication pass over the app's own forms (vendored `use/` trees — MSEgui, uos,
OvoTag, BGRABitmap — excluded) surfaced a set of copy-pasted routines, mostly
between `songplayer.pas` and the other forms it was grown from
(`waveform`/`recorder`/`main`). Each item below was confirmed by reading the
code; the line numbers are from the current `main` HEAD. Ordered by
value-to-effort (cleanest wins first).

None of these change behaviour — they collapse duplicated code so a future fix
only has to be made once (several past commits — "center dialog", dock layout,
EQ tweaks — had to be repeated across copies).

## High value, low risk

1. **`onmouseev` / `onmouseevw` are character-identical** — `songplayer.pas:3722`
   vs `waveform.pas:418`. The 20-line waveform mouse-release handler (seek +
   `InitDrawLive`/`InitDrawLivewav`) is byte-for-byte the same; only the method
   name differs. Both forms carry the same `panelwave` / `theplayer` / `tag`
   fields. → Give the two forms a shared ancestor (or a free helper taking the
   player + panel) and keep one copy.

2. **`onsetvalvol` duplicated verbatim** — `recorder.pas:1000` vs
   `songplayer.pas:3250` (~68-line spin-edit clamp/validate handler, identical
   bar the class prefix). → Shared method / helper.

3. **The dock-refresh block is pasted into 13 forms.** Every form's
   `visiblechangeev` embeds the same `if parentwidget = mainfo.basedock …
   updatelayoutstrum()` + `dockpanel1fo..dockpanel5fo … updatelayoutpan()` loop
   (~90 near-identical stanzas). Copies: `commander.pas:645`, `drums.pas:1118`,
   `equalizer.pas:652`, `filelistform.pas:620`, `guitars.pas:186`,
   `imagedancer.pas:1194` & `:1330`, `infosd.pas:136`, `piano.pas:170`,
   `recorder.pas:648`, `songplayer.pas:2937`, `spectrum1.pas:123`,
   `synthe.pas:538`, `waveform.pas:195`. → Extract one
   `refreshdocklayouts(const parentwidget: twidget)`; since `dockpanel1fo..5fo`
   are all the same class it further collapses to an array loop.

4. **The 10-band equalizer table is duplicated** — `recorder.pas:1098` vs
   `songplayer.pas:3120` (30 identical `Equalizer_Bands[n].lo_freq/hi_freq/Text`
   literal lines), and the `equalizer_band_type` record itself is redeclared in
   both (`recorder.pas:93`, `songplayer.pas:162`). → One shared unit with the
   record + a `const`/init routine.

## Medium

5. **`paintslider` reimplemented twice** in `songplayer.pas` as
   `paintsliderimage` (`:2216`) / `paintsliderimageform` (`:2315`), both close to
   `main.pas:281`. → Share the slider-drawing routine.

6. **`ontextedit` numeric-validate + "show-hint" block copy-pasted ~18×** across
   `commander.pas:930`, `drums.pas:2001`, `recorder.pas:1069`,
   `songplayer.pas:3319` (the validate differs only in the reset literal
   100/300; the `hintlabel.Caption … hintpanel.Width … timersent.restart` hint
   block is identical). → `showhint(msg)` + a validate helper.

7. **`updatelayoutstrum` / `updatelayoutpan`** (`main.pas:2589` /
   `dockpanel1.pas:263`) — two ~290-line layout routines whose core body is
   near-identical, differing only in which child forms each special-cases. →
   Factor the shared core, keep the per-container specializations.

8. **`InitDrawLive` draw-init duplicated** — `recorder.pas:199` vs
   `songplayer.pas:949`.

## Minor / consistency

9. **`RoundMath`** (both `double` and `single` overloads) is defined identically
   in `main.pas:265`, `alsa_mixer.pas:177`, `win_mixer.pas:133`. It's a
   deliberate cross-platform round-half-away-from-zero — the fix is to put the
   one definition in a shared util unit, not to reach for the RTL.

10. **`fptimer` vs the app's usual `msetimer`** — `drums.pas:15`,
    `infosd.pas:16` pull in `fptimer`/`tfptimer` where the rest of the app (14
    units) uses MSEgui `msetimer`/`ttimer`; `infosd` even names the field
    `ttimer1` but types it `tfptimer`. `fptimer` is thread-based, so this may be
    intentional for metronome timing — flagged only as a consistency review.

---

*Found with a static analysis pass ([argot](https://argot.tmonier.com), on its
new Pascal support) and hand-verified. Happy to send the actual refactor commits
(compile-tested) for any of these on request — starting with #1–#4, which are the
cleanest.*
