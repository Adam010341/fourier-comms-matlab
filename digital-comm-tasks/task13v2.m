% ---------------------------------------------------------
% L202 - Task 13: 數位化基頻訊號產生 (暴力代入法)
% 位元: [0 0 1 0 1 1 0 1 1 1], 速率 R = 2 bps (T = 0.5s)
% 硬體取樣率 Fs = 20 Hz
% ---------------------------------------------------------
clear; clc; close all;

%% 1. 系統與硬體參數設定
T = 0.5;            % 符號時間間距 = 0.5 秒
Fs = 20;            % DAC 取樣頻率 = 20 Hz (非常重要：這是離散化的關鍵)
bits = [0 0 1 0 1 1 0 1 1 1];
N = length(bits);

% 定義離散的取樣時間點陣列 (t = n * Ts)
% 10 個 bits 總共耗時 5 秒，我們觀察 t = 0 到 5 秒
t = 0 : 1/Fs : (N * T); 
x_base = zeros(size(t)); % 初始化將要餵給硬體的陣列 x_base[n]

%% 2. 暴力代入運算 (Method 1: Direct Substitution)
% 對於每一個 bit，產生對應的 Sinc 函數，並在對應的離散時間點取值累加
for k = 1:N
    % 第 k 個 bit 的中心平移時間 (0, 0.5, 1.0 ... 秒)
    shift_t = (k - 1) * T;
    
    % 將離散時間陣列 t 進行平移與正規化
    x_norm = (t - shift_t) / T;
    
    % 計算 Sinc 值 (處理 0/0)
    sinc_val = zeros(size(x_norm));
    idx_zero = (x_norm == 0);
    idx_nonzero = (x_norm ~= 0);
    sinc_val(idx_zero) = 1; 
    sinc_val(idx_nonzero) = sin(pi * x_norm(idx_nonzero)) ./ (pi * x_norm(idx_nonzero));
    
    % 根據位元決定正負號並疊加至總陣列
    if bits(k) == 0
        x_base = x_base + sinc_val;
    else
        x_base = x_base - sinc_val;
    end
end

%% 3. 繪圖觀測離散陣列
figure('Name', 'L202 Task 13: Discrete Baseband Array', 'Position', [150, 150, 900, 400]);

% 使用 stem 畫出離散取樣點 (這才是硬體真正看到的資料)
stem(t, x_base, 'b', 'filled', 'LineWidth', 1.5, 'MarkerSize', 5);
hold on; grid on;

% 標示出這 10 個 bit 的理想決策點 (紅點)
sample_times = (0:N-1) * T;
sample_vals = interp1(t, x_base, sample_times);
plot(sample_times, sample_vals, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

yline(0, 'k-', 'LineWidth', 1);
title('Task 13: Discrete Array x_{base}[n] (fs = 20Hz) for [0 0 1 0 1 1 0 1 1 1]');
xlabel('Time (seconds) - Discrete Steps');
ylabel('Amplitude (Digital Value)');
axis([-0.5 5.5 -1.5 1.5]);
set(gca, 'FontSize', 12);

% 加上數值標籤
for k = 1:N
    text(sample_times(k), sample_vals(k) + sign(sample_vals(k))*0.15, num2str(bits(k)), ...
        'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'Color', 'r');
end

disp(['產生的 x_base[n] 陣列長度為: ', num2str(length(x_base))]);
disp('前 10 個數值為:');
    