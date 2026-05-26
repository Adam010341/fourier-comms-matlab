% ---------------------------------------------------------
% L202 - Task 10: 繪製連續類比波形 x(t)
% 傳送位元: [1 1 0], 傳輸速率 R = 2 bps (T = 0.5s)
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統參數設定
T = 0.5;            % 符號時間間距 (Symbol Spacing) = 1/R = 0.5 秒
Fs = 2000;          % 繪圖用的高解析度取樣率 (用來模擬"連續"波形)
t = -2:1/Fs:3;      % 觀測時間軸：從 -2 到 3 秒

% 欲傳送的位元
bits = [1 1 0];
N = length(bits);

% 初始化總發射波形 x(t)
x_t = zeros(size(t));

%% 2. 波形疊加運算 (Superposition)
for k = 1:N
    % 計算第 k 個 bit 的中心時間 (0, 0.5, 1.0 秒)
    shift_t = (k - 1) * T;
    
    % 正規化時間變數
    x_norm = (t - shift_t) / T;
    
    % 建立底層 Sinc 函數 (處理 0/0 的 NaN 問題)
    sinc_val = zeros(size(x_norm));
    idx_zero = (x_norm == 0);
    idx_nonzero = (x_norm ~= 0);
    sinc_val(idx_zero) = 1; 
    sinc_val(idx_nonzero) = sin(pi * x_norm(idx_nonzero)) ./ (pi * x_norm(idx_nonzero));
    
    % 根據位元決定正負號並疊加
    % b=0 對應 f0(t) = +sinc(t/T)
    % b=1 對應 f1(t) = -sinc(t/T)
    if bits(k) == 0
        x_t = x_t + sinc_val;
    else
        x_t = x_t - sinc_val;
    end
end

%% 3. 繪圖與訊號觀測
figure('Name', 'L202 Task 10: Analog Waveform x(t)', 'Position', [150, 150, 800, 400]);

% 畫出連續波形
plot(t, x_t, 'b-', 'LineWidth', 2);
hold on; grid on;

% 標示出理想的觀測點 (t = 0, 0.5, 1.0)
sample_times = (0:N-1) * T;
sample_vals = interp1(t, x_t, sample_times);
plot(sample_times, sample_vals, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% 畫出零基準線
yline(0, 'k-', 'LineWidth', 1);

title('Task 10: Continuous Analog Waveform x(t) for bits [1 1 0]');
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([-1.5 2.5 -1.5 1.5]);
set(gca, 'FontSize', 12);

% 加上數值標籤
for k = 1:N
    if sample_vals(k) > 0
        text(sample_times(k), sample_vals(k) + 0.2, 'b=0', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    else
        text(sample_times(k), sample_vals(k) - 0.2, 'b=1', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');
    end
end

legend('x(t) (Superimposed Sinc)', 'Target Symbols at t=nT', 'Location', 'northeast');