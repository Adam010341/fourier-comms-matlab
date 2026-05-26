% ---------------------------------------------------------
% 基礎數位通訊 - Task 14: 純數值陣列版 Sinc 波形
% (保證不需任何 Toolbox 即可執行)
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統參數設定
T = 2;              % 符號時間間距 (Symbol Spacing) = 2 秒
Fs = 1000;          % 取樣頻率 (Sampling rate = 1000 Hz)
t = -5:1/Fs:15;     % 觀測時間軸：從 -5 到 15 秒

%% 2. 自己手刻 Sinc 函數 (處理 0/0 問題)
% 題目要求：發送位元 b=1，對應波形 f1(t) = -sinc(t/T)
% Sinc 函數定義為 sin(pi*x) / (pi*x)
x = t / T;          % 將時間軸正規化為 x 變數

% 預先建立一個全零陣列來存放結果
tx_signal = zeros(size(x));

% 找出 x = 0 的點與 x ~= 0 的點 (邏輯索引)
idx_zero = (x == 0);
idx_nonzero = (x ~= 0);

% 根據 Sinc 定義分別賦值 (避免 0/0 產生 NaN)
tx_signal(idx_zero) = 1; % 當 x=0 時，極限值為 1
tx_signal(idx_nonzero) = sin(pi * x(idx_nonzero)) ./ (pi * x(idx_nonzero));

% 因為我們要送 b=1，波形是負的 Sinc
tx_signal = -tx_signal;

%% 3. 繪圖顯示
figure('Name', 'Task 14: Single Bit b=1 (No Toolbox)', 'Position', [100, 100, 800, 400]);

plot(t, tx_signal, 'b-', 'LineWidth', 2);
hold on;
grid on;

% 標記發射中心點
plot(0, -1, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% 標記理論零點
zero_crossings = -4:2:14;
plot(zero_crossings, zeros(size(zero_crossings)), 'kx', 'MarkerSize', 8, 'LineWidth', 1.5);

title('Task 14: Transmitted Waveform for b=1 (Custom Sinc Function)');
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([-5 15 -1.2 0.5]);
set(gca, 'FontSize', 12);

legend('Transmitted Signal f_1(t) = -sinc(t/T)', 'Peak at t=0', 'Zero-crossings at t = nT', 'Location', 'southeast');
text(0, -0.8, 'Bit 1 transmitted at t=0', 'HorizontalAlignment', 'center', 'FontSize', 12, 'Color', 'r');

disp('Basic MATLAB Code Executed. No toolboxes required.');