#!/bin/bash

while true
do
    clear

    echo "====================================="
    echo "      BVRINFRA OPERATIONS MENU"
    echo "====================================="
    echo
    echo "1  - Cluster Health"
    echo "2  - Resource Trend"
    echo "3  - Cluster Pressure"
    echo "4  - Upgrade Readiness"
    echo "5  - Incident Mode"
    echo "6  - Full Validation"
    echo "7  - Show Nodes"
    echo "8  - Show Pods"
    echo "9  - Show PVCs"
    echo "10 - Show Ingress"
    echo "11 - Restart Analysis"
    echo "12 - Exit"
    echo
    read -p "Select Option: " option

    case $option in

        1)
            clear
            khealth
            ;;

        2)
            clear
            ktrend
            ;;

        3)
            clear
            kpressure
            ;;

        4)
            clear
            kupgrade-ready
            ;;

        5)
            clear
            kincident
            ;;

        6)
            clear
            kfull
            ;;

        7)
            clear
            kubectl get nodes -o wide
            ;;

        8)
            clear
            kubectl get pods -A
            ;;

        9)
            clear
            kubectl get pvc -A
            ;;

        10)
            clear
            kubectl get ingress -A
            ;;

        11)
            clear
            kubectl get pods -A --sort-by=.status.containerStatuses[0].restartCount
            ;;

        12)
            echo
            echo "Exiting Operations Menu..."
            echo
            exit 0
            ;;

        *)
            echo
            echo "Invalid Option"
            ;;

    esac

    echo
    read -p "Press ENTER to continue..."

done
