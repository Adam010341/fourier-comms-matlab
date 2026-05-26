% ---------------------------------------------------------
% 基礎數位通訊 - Task 12 (改良版：為 Task 13 鋪路)
% 每個 Symbol 傳送 2 bits，波形寬度 1 秒，發送間隔 T=2 秒
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統參數設定
Fs = 1000;          % 取樣頻率
T_pulse = 1;        % 波形持續時間 (Pulse duration) = 1 秒
T_shift = 2;        % 發射時間平移間距 (Shift spacing T) = 2 秒
t_pulse = 0:1/Fs:T_pulse; % 單一波形的時間向量 (0 到 1 秒)

%% 2. 定義四種基本波形 (Base waveforms)
% 利用不同頻率的 cos 波代表不同的 2-bit 組合
f00_t = cos(2*pi * 1 * t_pulse);  % 代表 '00'
f01_t = cos(2*pi * 2 * t_pulse);  % 代表 '01'
f10_t = cos(2*pi * 3 * t_pulse);  % 代表 '10'
f11_t = cos(2*pi * 4 * t_pulse);  % 代表 '11'

%% 3. 建構傳輸波形 (Tx Signal)
% 任務要求：依序傳送 '01' 和 '10'
% 總時間：兩個 T_shift，即 4 秒
t_total = 0:1/Fs:(2*T_shift);
tx_signal = zeros(size(t_total));

% 第一個波形 (發送 '01')：放在 t=0
idx_start1 = 1;
idx_end1 = length(t_pulse);
tx_signal(idx_start1:idx_end1) = f01_t;

% 第二個波形 (發送 '10')：放在 t = T_shift = 2
% 找出 t=2 秒在 t_total 中的索引位置
idx_start2 = find(t_total >= T_shift, 1);
idx_end2 = idx_start2 + length(t_pulse) - 1;
tx_signal(idx_start2:idx_end2) = f10_t;

%% 4. 繪圖顯示
figure('Name', 'Task 12: Sending 01 and 10 with T=2', 'Position', [100, 100, 800, 400]);

plot(t_total, tx_signal, 'b-', 'LineWidth', 1.5);
hold on; grid on;

% 畫出發射間隔的輔助線
xline(2, 'r--', 'LineWidth', 2);
xline(1, 'g:', 'LineWidth', 1.5); % 標示第一個波形結束
xline(3, 'g:', 'LineWidth', 1.5); % 標示第二個波形結束

title('Task 12: Tx Waveform (Pulse width = 1s, Shift Spacing T = 2s)');
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([0 4 -1.5 1.5]);
set(gca, 'FontSize', 12);

% 加上文字註解
text(0.5, 1.2, 'Bits: 01', 'HorizontalAlignment', 'center', 'FontSize', 12, 'Color', 'k');
text(1.5, 0.5, 'Wasted Time', 'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'r');
text(2.5, 1.2, 'Bits: 10', 'HorizontalAlignment', 'center', 'FontSize', 12, 'Color', 'k');
text(3.5, 0.5, 'Wasted Time', 'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'r');

disp('MATLAB Code Executed. Observe the blank spaces in the waveform.');