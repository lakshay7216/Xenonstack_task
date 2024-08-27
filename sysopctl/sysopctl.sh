#!/bin/bash

# sysopctl version
VERSION="0.1.0"

# Function to display the help message
function show_help() {
    echo "Usage: sysopctl [option]"
    echo "Options:"
    echo "  --help        Show this help message"
    echo "  --version     Show version information"
    echo "  service list  List all active services"
    echo "  service start <service-name>  Start a specified service"
    echo "  service stop <service-name>   Stop a specified service"
    echo "  system load   Display current system load"
    echo "  disk usage    Show disk usage by partition"
    echo "  process monitor  Monitor system processes in real-time"
    echo "  logs analyze  Analyze recent critical system logs"
    echo "  backup <path>  Backup specified directory"
}

# Function to display the version
function show_version() {
    echo "sysopctl version $VERSION"
}

# Function to list active services
function list_services() {
    systemctl list-units --type=service
}

# Function to display system load
function system_load() {
    uptime
}

# Function to start a service
function start_service() {
    systemctl start "$1"
    echo "Service $1 started."
}

# Function to stop a service
function stop_service() {
    systemctl stop "$1"
    echo "Service $1 stopped."
}

# Function to check disk usage
function disk_usage() {
    df -h
}

# Function to monitor system processes
function monitor_processes() {
    top
}

# Function to analyze system logs
function analyze_logs() {
    journalctl -p 3 -xb
}

# Function to backup system files
function backup_files() {
    rsync -avh --progress "$1" /backup/destination/
    echo "Backup of $1 initiated."
}

# Main script logic to handle input arguments
case "$1" in
    --help)
        show_help
        ;;
    --version)
        show_version
        ;;
    service)
        case "$2" in
            list)
                list_services
                ;;
            start)
                start_service "$3"
                ;;
            stop)
                stop_service "$3"
                ;;
            *)
                echo "Invalid service command. Use --help for more information."
                ;;
        esac
        ;;
    system)
        case "$2" in
            load)
                system_load
                ;;
            *)
                echo "Invalid system command. Use --help for more information."
                ;;
        esac
        ;;
    disk)
        case "$2" in
            usage)
                disk_usage
                ;;
            *)
                echo "Invalid disk command. Use --help for more information."
                ;;
        esac
        ;;
    process)
        case "$2" in
            monitor)
                monitor_processes
                ;;
            *)
                echo "Invalid process command. Use --help for more information."
                ;;
        esac
        ;;
    logs)
        case "$2" in
            analyze)
                analyze_logs
                ;;
            *)
                echo "Invalid logs command. Use --help for more information."
                ;;
        esac
        ;;
    backup)
        backup_files "$2"
        ;;
    *)
        echo "Invalid command. Use --help for more information."
        ;;
esac
