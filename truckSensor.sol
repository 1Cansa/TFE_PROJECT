// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

contract Truckchain {
    
    struct SensorData {
        uint256 flowRateSensor1;
        int256 temperatureSensor1;
        bool isTemperatureSet1;
        uint256 ultrasonicLevel; 
    }

    mapping(string => SensorData) private truckData;
    mapping(string => uint256) private flowRateSensor2;

    event FlowRateSensor1Updated(string truckPlate, uint256 flowRate);
    event FlowRateSensor2Updated(string truckPlate, uint256 flowRate);
    event TemperatureSensor1Updated(string truckPlate, int256 temperature);
    event UltrasonicLevelUpdated(string truckPlate, uint256 level);

    function setFlowRateSensor1(string memory truckPlate, uint256 flowRate) public {
        truckData[truckPlate].flowRateSensor1 = flowRate;
        emit FlowRateSensor1Updated(truckPlate, flowRate);
    }

    function setFlowRateSensor2(string memory truckPlate, uint256 flowRate) public {
        flowRateSensor2[truckPlate] = flowRate;
        emit FlowRateSensor2Updated(truckPlate, flowRate);
    }

    function setTemperatureSensor1(string memory truckPlate, int256 temperature) public {
        if (!truckData[truckPlate].isTemperatureSet1 || abs(truckData[truckPlate].temperatureSensor1 - temperature) >= 1) {
            truckData[truckPlate].temperatureSensor1 = temperature;
            truckData[truckPlate].isTemperatureSet1 = true;
            emit TemperatureSensor1Updated(truckPlate, temperature);
        }
    }

    function setUltrasonicLevel(string memory truckPlate, uint256 level) public {
        truckData[truckPlate].ultrasonicLevel = level;
        emit UltrasonicLevelUpdated(truckPlate, level);
    }

    function getFlowRateSensor1(string memory truckPlate) public view returns (uint256) {
        return truckData[truckPlate].flowRateSensor1;
    }

    function getFlowRateSensor2(string memory truckPlate) public view returns (uint256) {
        return flowRateSensor2[truckPlate];
    }

    function getTemperatureSensor1(string memory truckPlate) public view returns (int256) {
        return truckData[truckPlate].temperatureSensor1;
    }

    function getUltrasonicLevel(string memory truckPlate) public view returns (uint256) {
        return truckData[truckPlate].ultrasonicLevel;
    }

    function abs(int256 x) internal pure returns (int256) {
        return x >= 0 ? x : -x;
    }
}

