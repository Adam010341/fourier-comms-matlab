# 傅立葉轉換在類比與數位通訊的應用 — Purdue × NCKU(MATLAB)

![MATLAB](https://img.shields.io/badge/language-MATLAB-0076A8)
![Octave](https://img.shields.io/badge/verified%20with-GNU%20Octave%2010-0790C0?logo=octave&logoColor=white)
![Course](https://img.shields.io/badge/course-Purdue%20%C3%97%20NCKU-CEB888)
![Toolboxes](https://img.shields.io/badge/toolboxes-none-2ea44f)

[English](README.md) | **繁體中文**

這裡收錄的是成大課程 **傅立葉轉換在類比與數位通訊的應用**(*Applications of Fourier
Transforms on Analog and Digital Communications*,課號 1142_E222400)的 MATLAB 專題。這門課是成大與
Purdue 合辦的密集短期課程(2026 年 4–5 月),由**普渡大學 Elmore Family School of ECE 的王之群教授
(Prof. Chih-Chun Wang)** 全英文授課。

課程從摺積、傅立葉分析開始，一路講到實際的通訊系統，這個 repo 的順序也一樣:

| # | 資料夾 | 內容 | 相關概念 |
|---|--------|------|----------|
| 1 | [`project1-room-acoustics/`](project1-room-acoustics/) | 用拍手錄下真實空間的脈衝響應，再拿它和錄音室音檔做摺積，重現那個空間的聲學效果 | LTI 系統、脈衝響應、FFT 摺積 |
| 2 | [`project2-fourier-series/`](project2-fourier-series/) | 推導任意週期方波的傅立葉級數係數，再用係數把訊號合成回來 | CTFS 分析/合成、時移性質、Gibbs 現象 |
| 3 | [`project3-am-radio/`](project3-am-radio/) | 用軟體做 AM 收音機：多段音訊分頻多工到同一個訊號，再逐台解調出來 | AM-DSB / AM-SSB、FDM、理想帶通濾波、同調解調 |
| 4 | [`digital-comm-tasks/`](digital-comm-tasks/) | 課堂 task:把位元字串轉成類比波形 | 脈衝成形、sinc 脈衝與零符號間干擾、DAC 取樣陣列 |

<p align="center">
  <img src="docs/figures/p3_radio_spectra.png" width="720" alt="Project 3 兩個多工訊號的頻譜">
</p>

## 重點

- **軟體 AM 收音機**:[`cmd1.m`](project3-am-radio/cmd1.m)、[`cmd2.m`](project3-am-radio/cmd2.m) 把
  3 個 DSB 頻道，以及 6 個 SSB 頻道(1 個基頻 + 5 個下旁帶)分別合成到
  [`radio1.wav`](project3-am-radio/radio1.wav) 和 [`radio2.wav`](project3-am-radio/radio2.wav)。
  [`AMDSB.m`](project3-am-radio/AMDSB.m) 和 [`AMSSB.m`](project3-am-radio/AMSSB.m) 依序經過帶通濾波、
  乘上本地載波、再低通濾波，就能收聽任一台。
- **實測聲學數據**:我們錄了圖書館小房間和樓梯間的脈衝響應。樓梯間的聲能衰減 20 dB 需要 0.37 秒，
  大約是圖書館(0.18 秒)的兩倍，這和我們在摺積後的樓梯間音檔裡聽到較明顯的回音一致。
- **濾波器從原理手刻**:整個 repo 沒有用到 Signal Processing Toolbox。低通濾波器直接寫成
  `2B·sinc(2Bt)` 脈衝響應，帶通濾波器是兩個低通相減，濾波則用 FFT 摺積實作。

## 驗證

所有程式都用 GNU Octave 10.3 重新跑過，並且和當初繳交的檔案比對:

| 項目 | 結果 |
|------|------|
| `mainFunction.m` → `libraryConvolved.wav` | 與繳交檔逐 sample 相同 |
| `impulse_center.m` 處理 `Library 1.wav` / `Stairwell 1.wav` | 與繳交的置中脈衝響應相同 |
| `cmd1.m` / `cmd2.m` → `radio1.wav` / `radio2.wav` | 與 repo 內檔案逐 sample 相同 |
| `AMDSB(1..3)` | 每台都對到正確的來源(相關係數 ≥ 0.998),與其他來源的 \|相關係數\| < 0.02 |
| `AMSSB(1..6)` | 每台都對到正確的來源，與其他來源的 \|相關係數\| < 0.02 |
| `student_own_program.m` 的 a₀…a₆ | 與數值積分結果一致(最大誤差 4 × 10⁻⁶) |
| `task15.m`、`task16.m` | 在 t = kT 取樣剛好是 ±1,可以直接從波形讀出位元 |

## 書面作業(不公開)

除了專題，課程還有五份作業，題目大多出自 Oppenheim & Willsky。手寫解答不放在這裡，涵蓋範圍如下:

| 作業 | 主題 |
|------|------|
| HW1 | 微積分與算術複習：積分、連續/離散訊號的時移與縮放、部分分式、三角函數、複數 |
| HW2 | 系統性質(線性、非時變;OW 1.27、1.28、1.31);諧波相關複指數 |
| HW3 | 摺積(OW 2.21、2.22);連續時間移動平均系統;LTI 系統對複指數的響應;正交基底 |
| HW4 | 連續時間傅立葉級數(OW 3.21、3.22)與由係數還原訊號 |
| HW5 | 頻率響應(OW 3.33);2^−\|t\| 與方波的傅立葉轉換;帶限頻譜的反轉換;理想低通 sin(2t)/πt;OW 4.32、4.35 |

## 執行方式

每個資料夾都可以獨立執行：在 MATLAB 裡 `cd` 進去，照該資料夾的 README 操作即可。只用到 MATLAB 內建函式
(`fft`、`audioread`、`audiowrite`、`plot`),有幾個 task 用到 `xline`/`yline`,需要 R2018b 以上。

課程提供的原始音檔(project 1 的 `x1.wav`、project 3 的 `x1`–`x6`)**沒有**重新散布。不過
`radio1.wav` / `radio2.wav` 已經附在 repo 裡，所以 AM 接收端可以直接執行。

## 致謝

- 課程與作業設計：王之群教授(Purdue)。脈衝響應實驗改編自 Craig Manarik 與王之群教授為 Purdue ECE 301
  設計的教材。課程提供的輔助程式都已在各資料夾 README 中註明。
- 專題為小組合作：**范啟彥 Adam Fan**、Edward Li、Ken Lian、Andy Zheng。
- 教科書：A. V. Oppenheim, A. S. Willsky, S. H. Nawab, *Signals and Systems*, 2nd ed.

講義、作業題目與解答屬於授課教師的教材，不收錄在這個 repo。
