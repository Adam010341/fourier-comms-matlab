% ---------------------------------------------------------
% 基礎數位通訊 - Task 15: 發送 10 bits (Sinc 波形疊加)
% (保證不需任何 Toolbox 即可執行)
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統參數設定
T = 2;                  % 符號時間間距 (Symbol Spacing) = 2 秒
Fs = 1000;              % 取樣頻率
t = -5:1/Fs:25;         % 觀測時間軸：從 -5 到 25 秒
bits = [0 0 1 0 1 0 1 1 1 0]; % 欲傳送的 10 個位元
N = length(bits);

% 初始化總發射波形 (全為 0)
tx_signal = zeros(size(t));

%% 2. 產生並疊加波形
% 利用迴圈，將每一個 bit 轉換為對應的 Sinc 波形，並平移到正確的時間點
for k = 1:N
    % 計算第 k 個 bit 的中心時間 (0, 2, 4, 6... 秒)
    shift_t = (k - 1) * T;
    
    % 正規化時間變數 x
    x = (t - shift_t) / T;
    
    % 手刻 Sinc 函數 (處理 0/0 問題)
    sinc_val = zeros(size(x));
    idx_zero = (x == 0);
    idx_nonzero = (x ~= 0);
    sinc_val(idx_zero) = 1; 
    sinc_val(idx_nonzero) = sin(pi * x(idx_nonzero)) ./ (pi * x(idx_nonzero));
    
    % 判斷位元是 0 還是 1，決定正負號並疊加到總波形中
    if bits(k) == 0
        tx_signal = tx_signal + sinc_val;  % b=0 對應 f0(t) = +sinc
    else
        tx_signal = tx_signal - sinc_val;  % b=1 對應 f1(t) = -sinc
    end
end

%% 3. 繪圖顯示
figure('Name', 'Task 15: 10-bit Sinc Transmission', 'Position', [100, 100, 900, 400]);

plot(t, tx_signal, 'b-', 'LineWidth', 1.5);
hold on; grid on;

% --- 以下為幫助你理解的視覺化輔助線 ---

% 計算這 10 個 bit 的理想取樣時間點
sample_times = (0:N-1) * T;
% 根據 bit 數值計算理想的振幅 (0 -> +1, 1 -> -1)
sample_amplitudes = 1 - 2*bits; 

% 在圖上標示出完美的取樣點
plot(sample_times, sample_amplitudes, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

title('Task 15: Transmitted Waveform for 10 bits [0 0 1 0 1 0 1 1 1 0]');
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([-5 25 -2 2]);
set(gca, 'FontSize', 12);

% 在每個取樣點上方/下方標示出對應的 bit
for k = 1:N
    if bits(k) == 0
        text(sample_times(k), 1.2, '0', 'HorizontalAlignment', 'center', 'Color', 'k', 'FontWeight', 'bold');
    else
        text(sample_times(k), -1.2, '1', 'HorizontalAlignment', 'center', 'Color', 'k', 'FontWeight', 'bold');
    end
end

legend('Superimposed Tx Signal', 'Ideal Sampling Points (every T=2s)', 'Location', 'northeast');
disp('Task 15 MATLAB Code Executed.');