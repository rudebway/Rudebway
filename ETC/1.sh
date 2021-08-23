Dersu Uzala, [05.08.21 08:23]
[Forwarded from Ярослав Корда]
Команды Артему

sudo systemctl stop cortes && sudo ipcrm -a 
sudo zypper --gpg-auto-import-keys ref
sudo zypper --gpg-auto-import-keys install -y cairo-devel pkg-config python3-devel gobject-introspection-devel opt-python39*
sudo zypper in libjpeg62
rm -R ~/cortes/.venv
cortes-builder update -o && cortes-builder install CortesDiskMonitor
~/cortes/.venv/bin/pip3 install R2CortesBuilderTUI
wget http://10.78.1.67/file_update/atom.conf -O cortes/cortes/launcher/config/services.conf
~/cortes/.venv/bin/pip3 install CortesUrlTools --upgrade
cortes-builder install resulthost==1.3.7-beta webstreamhost smartmicrohost webui cameraautomatcs==0.1.14-alpha roadar roadarsdk accounthost --force
sudo ipcrm -a && sudo systemctl start cortes 
bash <(wget -qO- http://10.78.1.67/install_pysnmp.sh)
sudo /opt/python/bin/PyCortesSNMP generate /etc/snmp.json
sudo wget http://10.78.1.67/file_update/pysnmpd.service -O /usr/lib/systemd/system/pysnmpd.service
sudo systemctl daemon-reload
sudo systemctl start pysnmpd.service
sudo reboot
curl -X PUT "http://127.0.0.1:5238/configuration/%2F" -H "accept: */*" -H "Content-Type: application/json-patch+json" -d "{\"cameras\":{\"6a60ab24-9c01-11e9-a2a3-2a2ae2dbcce4\":{\"annotations\":{\"description\":\"\",\"designation\":\"Распознающая камера\",\"location\":{\"bindAddress\":\"Пусто\",\"bindGpsPoint\":{\"latitude\":0,\"longitude\":0}}},\"cType\":\"rtsp\",\"customization\":{\"radar\":{\"workWithoutRadar\":false},\"trafficAnalysing\":{\"filterTracksWithoutLine\":false}},\"disposition\":{\"orientation\":{\"pitch\":-7.47,\"roll\":0,\"yaw\":10.85},\"position\":{\"x\":0,\"y\":4.5,\"z\":0}},\"features\":{\"cameraBrightnessControl\":{\"config\":{\"defaultMode\":\"Day\",\"modeBehavior\":0,\"modes\":[{\"autoControl\":{\"desiredBrightnessValue\":7},\"backlight\":{\"backlightValue\":10,\"isEnabled\":true},\"behavior\":0,\"manualControl\":{\"diaphragmValue\":95,\"exposureValue\":80,\"gainValue\":92},\"name\":\"Night\",\"postprocessing\":{\"brightnessCorrectionValue\":0,\"contrastCorrectionValue\":10,\"isEnabled\":true}},{\"autoControl\":{\"desiredBrightnessValue\":20},\"backlight\":{\"backlightValue\":10,\"isEnabled\":false},\"behavior\":0,\"manualControl\":{\"diaphragmValue\":15,\"exposureValue\":50,\"gainValue\":24},\"name\":\"Day\",\"postprocessing\":{\"brightnessCorrectionValue\":93,\"contrastCorrectionValue\":35,\"isEnabled\":true}}],\"timedAuto\":{\"dayMode\":\"Day\",\"nightMode\":\"Night\"}},\"focusConfig\":{\"isAutofocusEnabled\":false,\"manualFocusValue\":23},\"fType\":\"cameraautomatcs\",\"isEnabled\":true},\"microwave\":{\"compensation\":{\"orientation\":{\"pitch\":0,\"roll\":0,\"yaw\":0},\"position\":{\"x\":0,\"y\":0,\"z\":0}},\"fType\":\"smartmicro\",\"isEnabled\":true,\"OutsidePolygonDeactivateTrack\":{\"value\":false}},\"radar\":{\"config\":{\"autoSwitchToRawMode\":true,\"defaultMode\":\"Normal\",\"geometryCompensation\":{\"orientation\":{\"pitch\":0,\"roll\":0,\"yaw\":0},\"position\":{\"x\":0,\"y\":0,\"z\":0}},\"trackOutOfPolygon\":true},\"fType\":\"smartmicro\",\"isEnabled\":true},\"recognition\":{\"fType\":\"roadar\",\"isEnabled\":false}},\"geometry\":{\"completed\":true,\"solveType\":\"olv\"},\"realtimeVariables\":{\"selectedBrightnessMode\":\"Day\"},\"scene\":{},\"view\":{\"distorsion\":{\"k1\":0,\"k2\":0,\"p1\":0,\"p2\":0},\"fieldOfView\":{\"x\":13.9,\"y\":10.5},\"projectionMatrix\":{\"m11\":9.080879,\"m12\":0,\"m13\":0,\"m14\":0,\"m21\":0,\"m22\":10.882921,\"m23\":0,\"m24\":0,\"m31\":0,\"m32\":0,\"m33\":-1.000002,\"m34\":-1,\"m41\":0,\"m42\":0,\"m43\":-1.000002,\"m44\":0},\"resolution\":{\"height\":2056,\"width\":2464}}}},\"general\":{\"signs\":{\"modification\":\"АТОМ ИС\",\"serial\":\"2A212305\"},\"timezone\":3},\"realtimeVariables\":{\"workmode\":\"Normal\"},\"system\":{\"variables\":{\"setupGeometry\":{\"tutorialComplete\":true},\"setupMarking\":{\"welcomeComplete\":true}}}}"
sudo systemctl stop cortes && sudo ipcrm -a && sudo systemctl start cortes



pglitecli reset
sudo su
moLD02p
cd /var/lib/minio/
rm -rf materials
exit