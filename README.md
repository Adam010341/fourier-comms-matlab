# Fourier Transforms in Analog & Digital Communications — Purdue × NCKU (MATLAB)

![MATLAB](https://img.shields.io/badge/language-MATLAB-0076A8)
![Octave](https://img.shields.io/badge/verified%20with-GNU%20Octave%2010-0790C0?logo=octave&logoColor=white)
![Course](https://img.shields.io/badge/course-Purdue%20%C3%97%20NCKU-CEB888)
![Toolboxes](https://img.shields.io/badge/toolboxes-none-2ea44f)

**English** | [繁體中文](README.zh-TW.md)

MATLAB projects from **Applications of Fourier Transforms on Analog and Digital Communications**
(傅立葉轉換在類比與數位通訊的應用, NCKU course 1142_E222400), a short NCKU–Purdue course
(April–May 2026) taught in English by **Prof. Chih-Chun Wang (王之群)** of Purdue University's
Elmore Family School of Electrical and Computer Engineering.

| # | Folder | What it does | Ideas |
|---|--------|--------------|-------|
| 1 | [`project1-room-acoustics/`](project1-room-acoustics/) | Measures a room's impulse response with a hand clap, then convolves studio audio with it | LTI systems, impulse response, convolution by FFT |
| 2 | [`project2-fourier-series/`](project2-fourier-series/) | Computes Fourier-series coefficients of a periodic rectangular pulse and rebuilds the signal | CTFS analysis/synthesis, time shift, Gibbs ringing |
| 3 | [`project3-am-radio/`](project3-am-radio/) | Software AM radio: multiplexes several audio clips onto one signal, then tunes in to each | AM-DSB and AM-SSB, FDM, band-pass filters, coherent demodulation |
| 4 | [`digital-comm-tasks/`](digital-comm-tasks/) | In-class tasks that turn bit strings into analog waveforms | Pulse shaping, sinc pulses and zero ISI, DAC sampling |

<p align="center">
  <img src="docs/figures/p3_radio_spectra.png" width="720" alt="Spectra of the two multiplexed radio signals built in project 3">
</p>

## Highlights

- [`cmd1.m`](project3-am-radio/cmd1.m) and [`cmd2.m`](project3-am-radio/cmd2.m) pack 3 DSB channels
  and 6 SSB channels (1 baseband + 5 lower-sideband) into
  [`radio1.wav`](project3-am-radio/radio1.wav) and [`radio2.wav`](project3-am-radio/radio2.wav).
  [`AMDSB.m`](project3-am-radio/AMDSB.m) and [`AMSSB.m`](project3-am-radio/AMSSB.m) tune in to one
  channel with a band-pass filter, a local carrier and a low-pass filter.
- We recorded impulse responses of a library room and a stairwell. The stairwell's sound energy
  takes about twice as long to fall by 20 dB (0.37 s vs 0.18 s).
- No Signal Processing Toolbox. Low-pass filters are `2B·sinc(2Bt)` impulse responses, band-pass
  filters are the difference of two low-pass filters, and filtering is FFT-based convolution.

## Verification

Scripts were re-run in GNU Octave 10.3 and compared with the originally submitted files:

- `mainFunction.m`, `cmd1.m`, `cmd2.m`: output WAVs identical sample for sample.
- `AMDSB(1..3)`, `AMSSB(1..6)`: each output matches its source clip and no other (|corr| < 0.02);
  DSB correlation with the right clip ≥ 0.998.
- `student_own_program.m`: a₀…a₆ match numerical integration (max error 4 × 10⁻⁶).
- `task15.m`, `task16.m`: samples at t = kT are exactly ±1.

## Running the code

Each folder is self-contained: `cd` into it in MATLAB and follow its README. Only base MATLAB is
used. A few task scripts call `xline`/`yline` (R2018b or later).

Course-provided input audio (`x1.wav`, and `x1`–`x6` for project 3) is not redistributed.
`radio1.wav` and `radio2.wav` are included, so the AM receivers run as-is.

## Credits

- Course and assignment design: Prof. Chih-Chun Wang, Purdue University. The impulse-response
  experiment is adapted from Purdue ECE 301 material by Craig Manarik and Chih-Chun Wang.
- Team: **Adam Fan**, Edward Li, Ken Lian and Andy Zheng.
- Textbook: A. V. Oppenheim, A. S. Willsky and S. H. Nawab, *Signals and Systems*, 2nd ed.

Lecture notes, homework handouts and solutions are the instructor's material and are not included.
