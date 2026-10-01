# 傅立葉轉換在類比與數位通訊的應用 — Purdue × NCKU(MATLAB)

![MATLAB](https://img.shields.io/badge/language-MATLAB-0076A8)
![Octave](https://img.shields.io/badge/verified%20with-GNU%20Octave%2010-0790C0?logo=octave&logoColor=white)
![Course](https://img.shields.io/badge/course-Purdue%20%C3%97%20NCKU-CEB888)
![Toolboxes](https://img.shields.io/badge/toolboxes-none-2ea44f)

[English](README.md) | **繁體中文**

這裡收錄的是成大課程 **傅立葉轉換在類比與數位通訊的應用**(*Applications of Fourier
Transforms on Analog and Digital Communications*,課號 1142_E222400)的 MATLAB 專題。這是成大與
Purdue 合辦的短期課程(2026 年 4–5 月),由**普渡大學 Elmore Family School of ECE 的王之群教授
(Prof. Chih-Chun Wang)** 全英文授課。

| # | 資料夾 | 內容 | 相關概念 |
|---|--------|------|----------|
| 1 | [`project1-room-acoustics/`](project1-room-acoustics/) | 用拍手錄下空間的脈衝響應,再和錄音室音檔做摺積 | LTI 系統、脈衝響應、FFT 摺積 |
| 2 | [`project2-fourier-series/`](project2-fourier-series/) | 計算週期方波的傅立葉級數係數,再合成回訊號 | CTFS 分析/合成、時移、Gibbs 現象 |
| 3 | [`project3-am-radio/`](project3-am-radio/) | 軟體 AM 收音機:多段音訊分頻多工到同一訊號,再逐台解調 | AM-DSB / AM-SSB、FDM、帶通濾波、同調解調 |
| 4 | [`digital-comm-tasks/`](digital-comm-tasks/) | 課堂 task:把位元字串轉成類比波形 | 脈衝成形、sinc 脈衝與零 ISI、DAC 取樣 |

<p align="center">
  <img src="docs/figures/p3_radio_spectra.png" width="720" alt="Project 3 兩個多工訊號的頻譜">
</p>

## 重點

- [`cmd1.m`](project3-am-radio/cmd1.m)、[`cmd2.m`](project3-am-radio/cmd2.m) 把 3 個 DSB 頻道與
  6 個 SSB 頻道(1 個基頻 + 5 個下旁帶)分別合成到
  [`radio1.wav`](project3-am-radio/radio1.wav) 和 [`radio2.wav`](project3-am-radio/radio2.wav)。
  [`AMDSB.m`](project3-am-radio/AMDSB.m)、[`AMSSB.m`](project3-am-radio/AMSSB.m) 經過帶通濾波、
  乘上本地載波、再低通濾波,收聽任一台。
- 我們錄了圖書館小房間和樓梯間的脈衝響應。樓梯間聲能衰減 20 dB 需要 0.37 秒,約為圖書館(0.18 秒)的兩倍。
- 沒有用 Signal Processing Toolbox。低通濾波器寫成 `2B·sinc(2Bt)` 脈衝響應,帶通是兩個低通相減,
  濾波用 FFT 摺積。

## 驗證

程式以 GNU Octave 10.3 重新執行,並與當初繳交的檔案比對:

- `mainFunction.m`、`cmd1.m`、`cmd2.m`:輸出 WAV 逐 sample 相同。
- `AMDSB(1..3)`、`AMSSB(1..6)`:每台都對到正確來源,與其他來源 |相關係數| < 0.02;DSB 對正確來源 ≥ 0.998。
- `student_own_program.m`:a₀…a₆ 與數值積分一致(最大誤差 4 × 10⁻⁶)。
- `task15.m`、`task16.m`:在 t = kT 取樣剛好是 ±1。

## 執行方式

每個資料夾可獨立執行:在 MATLAB 裡 `cd` 進去,照該資料夾的 README 操作。只用 MATLAB 內建函式,
有幾個 task 用到 `xline`/`yline`,需要 R2018b 以上。

課程提供的原始音檔(project 1 的 `x1.wav`、project 3 的 `x1`–`x6`)沒有重新散布。
`radio1.wav` / `radio2.wav` 已附在 repo 裡,AM 接收端可直接執行。

## 致謝

- 課程與作業設計:王之群教授(Purdue)。脈衝響應實驗改編自 Craig Manarik 與王之群教授為 Purdue ECE 301
  設計的教材。
- 小組成員:**范啟彥 Adam Fan**、Edward Li、Ken Lian、Andy Zheng。
- 教科書:A. V. Oppenheim, A. S. Willsky, S. H. Nawab, *Signals and Systems*, 2nd ed.

講義、作業題目與解答屬於授課教師的教材,不收錄在這個 repo。
