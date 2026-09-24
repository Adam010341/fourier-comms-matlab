# Project 3 — A software AM radio (DSB and SSB)

**Idea.** Several audio clips share one "airwave" through frequency-division multiplexing. Each
clip is band-limited to 1 kHz and shifted up to its own carrier frequency. A receiver tunes in to
one station with three steps: pick out its band, multiply by a local carrier to shift it back to
baseband, then low-pass filter. Every filter here is an ideal (sinc) filter written out by hand
and applied with FFT-based convolution (`ece301conv.m`). No toolbox is used.

<p align="center">
  <img src="../docs/figures/p3_radio_spectra.png" width="700" alt="Spectra of radio1.wav (3 DSB channels) and radio2.wav (baseband + 5 SSB channels)">
</p>

## Transmitters — building the multiplexed signals

| Script | Output | Channel plan |
|--------|--------|--------------|
| `cmd1.m` | `radio1.wav` | **AM-DSB**: clips x1, x2, x3 are low-passed to 1 kHz and multiplied by cos(2πfct) with fc = 1, 3.5 and 6 kHz |
| `cmd2.m` | `radio2.wav` | **AM-SSB (lower sideband)**: x1 stays at baseband (0–1 kHz); x2…x6 are low-passed to 1 kHz, modulated at fc = 2.2, 3.3, 4.4, 5.5 and 6.6 kHz, and low-passed at fc so that only the lower sideband remains. The channels sit 1.1 kHz apart; a DSB channel needs 2 kHz |

## Receivers — tuning in

| Function | Channels | Chain |
|----------|----------|-------|
| `AMDSB(ch)` | 1–3 | Band-pass around the station (ch 1: LPF 2 kHz; ch 2: 2.4–4.6 kHz; ch 3: 4.8–7.2 kHz) → × 2cos(2πfct) → LPF 1 kHz |
| `AMSSB(ch)` | 1–6 | ch 1: LPF 1 kHz. ch 2–6: band-pass [fc − 1.1 kHz, fc] → × 4cos(2πfct) → LPF 1 kHz → normalize |

A band-pass filter is built as the difference of two ideal low-pass filters,
h_BP(t) = 2B₂·sinc(2B₂t) − 2B₁·sinc(2B₁t). The carrier gain is 2 for DSB and 4 for SSB because
SSB keeps only one of the two half-amplitude sidebands.

**Verification (GNU Octave 10.3).** Re-running `cmd1.m` and `cmd2.m` reproduces the committed
`radio1.wav` and `radio2.wav` sample for sample. We checked each receiver output against all six
source clips:

- `AMDSB(1..3)` matches its own source with correlation ≥ 0.998.
- Every `AMSSB` channel correlates most strongly with its own source.
- Crosstalk with the other clips stays below 0.02 in every case.

## Prelab scripts

| Script | What it does |
|--------|--------------|
| `pre1.m` | Modulates a 1 kHz-band-limited clip onto a 4 kHz carrier, demodulates it coherently and overlays the input and output to show that they match |
| `pre2.m` | Extracts the 5–7.5 kHz band from a course-provided `radio.wav` and demodulates the station at 6.5 kHz |

## Run

```matlab
y = AMDSB(2);  sound(y, 44100)   % station 2 of radio1.wav
y = AMSSB(4);  sound(y, 44100)   % station 4 of radio2.wav
```

`radio1.wav` and `radio2.wav` are included. `cmd1.m`, `cmd2.m`, `pre1.m` and `pre2.m` also need
the course-provided clips `x1.wav`…`x6.wav` and `radio.wav`, which are not redistributed.
`AMDSB.m` and `AMSSB.m` start from the course's function skeleton; the bodies are ours.
`ece301conv.m` is course-provided.
