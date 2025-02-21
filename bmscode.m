   Voltage  % Array of cell voltages
        Current  % Array of cell currents
        Temperature % Array of cell temperatures
        SoC % State of Charge for each cell
    
    
    methods
        function obj = BatteryManagementSystem(voltage, current, temperature)
            obj.Voltage = voltage;
            obj.Current = current;
            obj.Temperature = temperature;
            obj.SoC = obj.calculateSoC();
        end
        
        function SoC = calculateSoC(obj)
            % Simple SoC estimation based on voltage
            % Assume voltage range is 2.5V to 4.2V for lithium-ion cells
            SoC = (obj.Voltage - 2.5) / (4.2 - 2.5);
            SoC(SoC < 0) = 0;
            SoC(SoC > 1) = 1;
        end
        
        function checkSafety(obj)
            % Check voltage and temperature limits
            voltageLimit = 4.2; % Max cell voltage
            tempLimit = 60; % Max cell temperature
            
            if any(obj.Voltage > voltageLimit)
                warning('Cell voltage exceeds safe limits!');
            end
            
            if any(obj.Temperature > tempLimit)
                warning('Cell temperature exceeds safe limits!');
            end
        end
        
        function balanceCells(obj)
            % Simple balancing logic (for demonstration purposes)
            avgVoltage = mean(obj.Voltage);
            obj.Voltage = obj.Voltage + (avgVoltage - obj.Voltage) * 0.1; % Basic balancing
        end
    end


% Example usage
voltage = [3.6, 3.7, 3.5, 3.8]; % Sample voltages for 4 cells
current = [1, 1, 1, 1]; % Sample currents
temperature = [25, 26, 25, 27]; % Sample temperatures

bms = BatteryManagementSystem(voltage, current, temperature);
disp(bms.SoC);
bms.checkSafety();
bms.balanceCells();
disp(bms.Voltage);