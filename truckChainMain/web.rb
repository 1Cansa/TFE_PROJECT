# frozen_string_literal: true

require 'eth'

# Adresse du nœud Ganache
GANACHE_URL = 'http://127.0.0.1:7545'
CONTRACT_ABI = <<-ABI
[
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "flowRate",
                "type": "uint256"
            }
        ],
        "name": "FlowRateSensor1Updated",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "flowRate",
                "type": "uint256"
            }
        ],
        "name": "FlowRateSensor2Updated",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "flowRate",
                "type": "uint256"
            }
        ],
        "name": "setFlowRateSensor1",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "flowRate",
                "type": "uint256"
            }
        ],
        "name": "setFlowRateSensor2",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "internalType": "int256",
                "name": "temperature",
                "type": "int256"
            }
        ],
        "name": "setTemperatureSensor1",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "int256",
                "name": "temperature",
                "type": "int256"
            }
        ],
        "name": "setTemperatureSensor2",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "internalType": "uint256",
                "name": "level",
                "type": "uint256"
            }
        ],
        "name": "setUltrasonicLevel",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "int256",
                "name": "temperature",
                "type": "int256"
            }
        ],
        "name": "TemperatureSensor1Updated",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "int256",
                "name": "temperature",
                "type": "int256"
            }
        ],
        "name": "TemperatureSensor2Updated",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "level",
                "type": "uint256"
            }
        ],
        "name": "UltrasonicLevelUpdated",
        "type": "event"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            }
        ],
        "name": "getFlowRateSensor1",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getFlowRateSensor2",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            }
        ],
        "name": "getTemperatureSensor1",
        "outputs": [
            {
                "internalType": "int256",
                "name": "",
                "type": "int256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getTemperatureSensor2",
        "outputs": [
            {
                "internalType": "int256",
                "name": "",
                "type": "int256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "truckPlate",
                "type": "string"
            }
        ],
        "name": "getUltrasonicLevel",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    }
]
ABI
CONTRACT_ADDRESS = '0x298bdf0044F40ed75a38224fc5b9e58411283Bac'

client = Eth::Client.create(GANACHE_URL)
contract = Eth::Contract.from_abi(name: 'MyContract', address: CONTRACT_ADDRESS, abi: CONTRACT_ABI)

# Fonctions pour interagir avec le contrat intelligent

# Exemple d'appel pour définir le capteur de débit 1
def set_flow_rate_sensor1(truck_plate, flow_rate)
  contract.transact_and_wait.setFlowRateSensor1(truck_plate, flow_rate)
  puts "Capteur de débit 1 défini pour #{truck_plate} avec un débit de #{flow_rate}"
end

# Exemple d'appel pour définir le capteur de débit 2
def set_flow_rate_sensor2(flow_rate)
  contract.transact_and_wait.setFlowRateSensor2(flow_rate)
  puts "Capteur de débit 2 défini avec un débit de #{flow_rate}"
end

# Exemple d'appel pour définir le capteur de température 1
def set_temperature_sensor1(truck_plate, temperature)
  contract.transact_and_wait.setTemperatureSensor1(truck_plate, temperature)
  puts "Capteur de température 1 défini pour #{truck_plate} avec une température de #{temperature}"
end

# Exemple d'appel pour définir le capteur de température 2
def set_temperature_sensor2(temperature)
  contract.transact_and_wait.setTemperatureSensor2(temperature)
  puts "Capteur de température 2 défini avec une température de #{temperature}"
end

# Exemple d'appel pour définir le niveau ultrasonique
def set_ultrasonic_level(truck_plate, level)
  contract.transact_and_wait.setUltrasonicLevel(truck_plate, level)
  puts "Niveau ultrasonique défini pour #{truck_plate} avec un niveau de #{level}"
end

# Exemple d'appel pour obtenir le capteur de débit 1
def get_flow_rate_sensor1(truck_plate)
  result = client.call(contract, 'getFlowRateSensor1', truck_plate)
  puts "Capteur de débit 1 pour #{truck_plate}: #{result}"
end

# Exemple d'appel pour obtenir le capteur de débit 2
def get_flow_rate_sensor2
  result = client.call(contract, 'getFlowRateSensor2')
  puts "Capteur de débit 2: #{result}"
end

# Exemple d'appel pour obtenir le capteur de température 1
def get_temperature_sensor1(truck_plate)
  result = client.call(contract, 'getTemperatureSensor1', truck_plate)
  puts "Capteur de température 1 pour #{truck_plate}: #{result}"
end

# Exemple d'appel pour obtenir le capteur de température 2
def get_temperature_sensor2
  result = client.call(contract, 'getTemperatureSensor2')
  puts "Capteur de température 2: #{result}"
end

# Exemple d'appel pour obtenir le niveau ultrasonique
def get_ultrasonic_level(truck_plate)
  result = client.call(contract, 'getUltrasonicLevel', truck_plate)
  puts "Niveau ultrasonique pour #{truck_plate}: #{result}"
end


# Exemples d'utilisation des fonctions

# Appel pour définir le capteur de débit 1 pour un camion spécifique
#set_flow_rate_sensor1("ABC123", 100)

# Appel pour définir le capteur de débit 2
#set_flow_rate_sensor2(200)

# Appel pour obtenir le capteur de débit 1 pour un camion spécifique
#get_flow_rate_sensor1("ABC123")

# Appel pour obtenir le capteur de débit 2
#get_flow_rate_sensor2
# Appel pour définir le capteur de température 1 pour un camion spécifique
set_temperature_sensor1("ABC123", 25)

# Appel pour définir le capteur de température 2
#set_temperature_sensor2(30)

# Appel pour obtenir le capteur de température 1 pour un camion spécifique
truck_plate = "4168AB04"
result = client.call(contract, 'getTemperatureSensor1', truck_plate)
  puts "Capteur de température 1 pour #{truck_plate}: #{result}"

# Appel pour obtenir le capteur de température 2
#get_temperature_sensor2

# Appel pour définir le niveau ultrasonique pour un camion spécifique
#set_ultrasonic_level("ABC123", 50)

# Appel pour obtenir le niveau ultrasonique pour un camion spécifique

