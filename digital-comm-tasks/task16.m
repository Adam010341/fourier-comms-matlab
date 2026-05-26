% ---------------------------------------------------------
% 基礎數位通訊 - Task 16: 發送字串 1011010111 (Sinc 疊加)
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統參數與位元設定
T = 2;                  % 符號時間間距 (Symbol Spacing) = 2 秒
Fs = 1000;              % 取樣頻率
t = -5:1/Fs:25;         % 觀測時間軸：從 -5 到 25 秒

% Task 16 指定的新位元字串
bits = [1 0 1 1 0 1 0 1 1 1]; 
N = length(bits);

% 初始化總發射波形 (全為 0)
tx_signal = zeros(size(t));

%% 2. 產生並疊加波形 (完全無 Toolbox 版本)
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

%% 3. 繪圖顯示與「解碼捷徑」標示
figure('Name', 'Task 16: 10-bit Sinc Transmission (1011010111)', 'Position', [100, 100, 900, 400]);

% 畫出疊加後的連續類比波形
plot(t, tx_signal, 'b-', 'LineWidth', 1.5);
hold on; grid on;

% --- Task 16 核心回答：解碼捷徑 ---
% 計算理想取樣時間點 (每隔 T=2 秒)
sample_times = (0:N-1) * T;
% 標示出取樣點的真實數值
sample_amplitudes = interp1(t, tx_signal, sample_times); 

% 用顯眼的紅點畫出這些「觀測瞬間」
plot(sample_times, sample_amplitudes, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
yline(0, 'k-', 'LineWidth', 1); % 畫出 0 基準線方便判斷正負

title('Task 16: Tx Waveform for [1 0 1 1 0 1 0 1 1 1] & Sampling Instants');
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([-5 25 -2 2]);
set(gca, 'FontSize', 12);

% 在紅點處自動標示判斷出的位元
for k = 1:N
    if sample_amplitudes(k) > 0
        text(sample_times(k), 1.3, '0', 'HorizontalAlignment', 'center', 'Color', 'k', 'FontWeight', 'bold');
    else
        text(sample_times(k), -1.3, '1', 'HorizontalAlignment', 'center', 'Color', 'k', 'FontWeight', 'bold');
    end
end

legend('Continuous Analog Waveform', 'Sampling Instants (t = nT)', 'Location', 'northeast');
disp('Task 16 MATLAB Code Executed. Look at the Red Dots!');