#!/bin/bash

find ~/ops-logs -type f -name "*.log" -size +20M -delete
