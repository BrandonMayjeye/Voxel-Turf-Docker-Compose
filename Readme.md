# Voxel Turf Game Server W/ Mods For Docker-Compose





## Installation Instructions
- Clone the above repo or extract the zip into a folder
- Modify config.json to your liking
- Install Docker and Docker- Compose, or docker desktop
- If you want to debug run `docker compose up --build`
- For hosting run `docker compose up -d' and you should be all ready to go



### Linux Installation Instructions
- for this example the game will be stored in opt/Docker-Games/Voxel-Turf
- Move the files with ftp or git
- cd into the opt/Docker-Games/Voxel-Turf directory
- run chmod +x configuration/start-server.sh to allow execution action as this file is linked from above  



## Untested Linux Fast Install
- navigate to any folder
- run `git clone https://github.com/BrandonMayjeye/Voxel-Turf-Docker-Compose.git`
- `cd oxel-Turf-Docker-Compose`
- ` sudo  chmod +x configuration/start-server.`
- ` sudo docker compose up -d`



### Advanced Options


``` json
"gameModeVars": {
    "gm1": "ON", Bases Allowed
    "gm2": 4, Ai Factions
    "gm3": 1, Ai Start Bases
    "gm4": "OFF",Ai Can start war
    "gm5": 1, Block Place 
    "gm6": 1000000, Start $$$
    "gm7": 1000000, Start Credits
    "gm8": 50, $$$ pre hour
    "gm9": 100, Credits per hour
    "gm10": "OFF", Inite Cash
    "gm11": "OFF", infinite credits
    "gm12": 2,Base Limit Rate 2= Double
    "gm13": "ON", Bloick Place Allowed
    "gm14": "ON", Weapon use allowed
    "gm15": "0, 1", Starting items
    "gm16": "538, 80",
    "gm17": "65535, 0",
    "gm18": "65535, 0",
    "gm19": "65535, 0",
    "gm20": "65535, 0",
    "gm21": "65535, 0",
    "gm22": "65535, 0",
    "gm23": "65535, 0",
    "gm24": "65535, 0"
  }
  ```