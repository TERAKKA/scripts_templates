#!/usr/bin/env python
import requests
import json
import time
from datetime import datetime
from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

MONITOR_JOB_NAME = "JSON_JOB_MONITOR"
INSTANCE_MONITOR = "url:port"
VEB_IT_SERVICE   = "service"
JSON_JOB_URL     = "http://url_port/services/Monitoring/Jobs"
prometheusServer = 'urlPrmths:port'

def send_to_prometheus_gauge(prometheusServer, metricName, comment, exported_job, job_subname, value):
    registry = CollectorRegistry()
    prom_gauge = Gauge(metricName, comment, ['in','it','job'], registry=registry)
    prom_gauge.labels(INSTANCE_MONITOR, VEB_IT_SERVICE,job_subname).set(value)
    push_to_gateway(prometheusServer, job=job_subname, registry=registry)
    time.sleep(1)

### JOB
print(datetime.now().strftime("[%d/%m/%Y %H:%M:%S] ") + "* * * " + MONITOR_JOB_NAME + " RUN " + "* * *")

#with open('json_monitoring.txt') as json_file:
#    data = json.load(json_file)
data = requests.get(JSON_JOB_URL).json()
jobs = data['json_row']

for job in jobs:
    print(datetime.now().strftime("[%d/%m/%Y %H:%M:%S] ") + job['job_subname'] + " - " + str(1 if (job['status']=='SUCCEEDED') else 0))
    send_to_prometheus_gauge(prometheusServer, 'job_monitor', 'STEP-Job Minitoring', 'json_monitoring', job['job_subname'], 1 if (job['status']=='SUCCEEDED') else 0)

print(datetime.now().strftime("[%d/%m/%Y %H:%M:%S] ") + "* * * " + MONITOR_JOB_NAME + " END " + "* * *")

exit(0)
