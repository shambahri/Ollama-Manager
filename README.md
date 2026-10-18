# 🦙 Ollama Model Backup & Restore Utility

A lightweight, interactive Bash script designed for macOS/Linux to easily back up and restore your local **Ollama** models using `rsync`. Perfect for migrating models to a new machine or backing them up to an external drive.

## ✨ Features

* **Interactive Menu:** Simple text-based prompt to choose between backup, restore, or exit.
* **Safe & Efficient:** Uses `rsync` with archive mode (`-av`) and live progress indicators to ensure robust file transfers without re-copying unchanged files.
* **Pre-flight Checks:** Automatically checks if your source directory and external drive are properly mounted before running.
* **Color-Coded Output:** Clear success, warning, and error messages for an improved terminal experience.

---

## 🚀 Getting Started

### 1. Save the Script
Save the script file on your machine as `ollama_backup.sh`.

### 2. Make the Script Executable
Open your terminal and run the following command to grant execution permissions:

```bash
chmod +x ollama_backup.sh

./ollama_backup.sh

=========================================================
 Ollama Model Management Utility 
=========================================================
NOTE: Please ensure all paths in the CONFIGURATION ZONE are correct.
This script uses rsync for reliable backup and restore.

Available Commands:
   1) 💾 Backup Models (Source Mac -> External Drive)
   2) 🔄 Restore Models (External Drive -> Target Mac)
   3) 🏠 Exit

Option 1 (Backup): Transfers your local models from ~/.ollama/models/ to your external drive.

Option 2 (Restore): Copies models from your external drive backup back into your local Ollama folder on a new or existing machine.

🛠️ Requirements
Bash Shell

rsync (pre-installed on macOS and most Linux distributions)

📄 License
This project is licensed under the MIT License - feel free to modify and share!
