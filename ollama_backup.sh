#!/bin/bash

# ===============================================================================
# 🔴 CRITICAL USER CONFIGURATION ZONE 🔴
# -------------------------------------------------------------------------------
# 1. SOURCE_DIR: The folder containing the models on the machine WITH models.
SOURCE_DIR="$HOME/.ollama/models/"

# 2. DEST_DRIVE: The root path of the external drive (e.g., /Volumes/Space)
DEST_DRIVE="/Volumes/Space"

# 3. Model Subfolder: The subfolder name that rsync should manage
BACKUP_SUBDIR="ollama_models"

# 4. (FOR RESTORE ONLY) Full path to the backup folder on the external drive.
RESTORE_SOURCE="$DEST_DRIVE/$BACKUP_SUBDIR/"

# ===============================================================================
# 🟢 END OF CONFIGURATION ZONE. DO NOT EDIT BELOW THIS LINE unless required.
# ===============================================================================


# --- ANSI Color Codes for better terminal readability ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ---------------------------------------------------
# Function to show the main menu and instructions
# ---------------------------------------------------
show_help() {
    echo -e "\n========================================================="
    echo -e "${BLUE} Ollama Model Management Utility ${NC}"
    echo "========================================================="
    echo "NOTE: Please ensure all paths in the CONFIGURATION ZONE are correct."
    echo "This script uses rsync for reliable backup and restore."
    echo ""
    echo -e "${YELLOW}Available Commands:${NC}"
    echo "   1) 💾 Backup Models (Source Mac -> External Drive)"
    echo "   2) 🔄 Restore Models (External Drive -> Target Mac)"
    echo "   3) 🏠 Exit"
}

# ---------------------------------------------------
# Function to handle the Backup process
# ---------------------------------------------------
run_backup() {
    echo -e "\n${BLUE}=========================================================${NC}"
    echo -e "${BLUE}        MODE: BACKUP MODE (Source -> External)      ${NC}"
    echo -e "${BLUE}=========================================================${NC}"

    if [ ! -d "$SOURCE_DIR" ]; then
        echo -e "${RED}🚨 ERROR: Source directory not found! Check SOURCE_DIR in the script.${NC}"
        return 1
    fi

    if [ ! -d "$DEST_DRIVE" ]; then
        echo -e "${RED}🚨 FATAL ERROR: Destination drive '$DEST_DRIVE' not found or mounted! Cannot proceed.${NC}"
        return 1
    fi

    echo -e "${YELLOW}Starting backup... ${NC}"
    echo "Model Source: $SOURCE_DIR"
    echo "Backup Destination: ${DEST_DRIVE}/${BACKUP_SUBDIR}"
    echo "---------------------------------------------------------"

    # Rsync command for backup
    rsync -av --progress "$SOURCE_DIR" "${DEST_DRIVE}/${BACKUP_SUBDIR}/"

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}=========================================================${NC}"
        echo -e "${GREEN}✅ SUCCESS! Model backup completed successfully! ${NC}"
        echo "Data is saved in: ${BLUE}$DEST_DRIVE/${BACKUP_SUBDIR}${NC}"
        echo "========================================================="
    else
        echo -e "\n${RED}=========================================================${NC}"
        echo -e "${RED}❌ FAILURE! The backup process encountered an error. Check paths and permissions.${NC}"
        echo "========================================================="
    fi
}

# ---------------------------------------------------
# Function to handle the Restore process
# ---------------------------------------------------
run_restore() {
    echo -e "\n${BLUE}=========================================================${NC}"
    echo -e "${BLUE}        MODE: RESTORE MODE (External -> Target)      ${NC}"
    echo -e "${BLUE}=========================================================${NC}"

    if [ ! -d "$RESTORE_SOURCE" ]; then
        echo -e "${RED}🚨 ERROR: Restore source directory not found! Check RESTORE_SOURCE in the script.${NC}"
        echo "Could not locate: $RESTORE_SOURCE. Please verify the external drive is mounted."
        return 1
    fi

    # We must ensure the target directory structure exists before restoring
    mkdir -p ~/.ollama/models/

    echo -e "${YELLOW}WARNING: This will copy/overwrite models in your current Ollama directory.${NC}"
    echo "Restoring models from: $RESTORE_SOURCE"
    echo "To Target Directory: ~/.ollama/models/"
    echo "---------------------------------------------------------"

    # Rsync command for restore
    rsync -av --progress "$RESTORE_SOURCE" "$HOME/.ollama/models/"

    if [ $? -eq 0 ]; then
        echo -e "\n${GREEN}=========================================================${NC}"
        echo -e "${GREEN}✅ SUCCESS! Models restored successfully! ${NC}"
        echo "========================================================="
        echo -e "${YELLOW}❗ FINAL STEP: To use the models, run the following command:${NC}"
        echo "    ollama run <model_name>"
        echo "========================================================="
    else
        echo -e "\n${RED}=========================================================${NC}"
        echo -e "${RED}❌ FAILURE! The restore process encountered an error. Check paths and permissions.${NC}"
        echo "========================================================="
    fi
}

# ---------------------------------------------------
# Main Menu Loop
# ---------------------------------------------------
main_menu() {
    while true; do
        show_help
        read -p "Enter your choice (1, 2, or 3): " choice

        case "$choice" in
            1)
                run_backup
                ;;
            2)
                run_restore
                ;;
            3)
                echo -e "\n${BLUE}Goodbye! Safe traveling with your models. ${NC}"
                exit 0
                ;;
            *)
                echo -e "\n${RED}❓ Invalid choice. Please enter 1, 2, or 3.${NC}"
                ;;
        esac
    done
}

# Start the script execution
main_menu
