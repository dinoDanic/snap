#!/bin/bash
#
/app/snap/bin/snap eval "RelaseTasks.migrate"
/app/snap/bin/snap start

# /app/holiday_shops/bin/holiday_shops eval "HolidayShops.ReleaseTasks.migrate"
# /app/holiday_shops/bin/holiday_shops start
#
# mix ecto.migrate && mix phx.server
