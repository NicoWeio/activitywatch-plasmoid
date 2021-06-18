import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents

Item {
    id: analogclock
    // width: units.gridUnit * 15
    // height: units.gridUnit * 15

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    ListModel {
        id: dasModel
    }

    PlasmaCore.DataSource {
        id: dataSource
        engine: "time"
        connectedSources: "Local"
        interval: 60*1000
        onDataChanged: {
            updateData();
        }
        Component.onCompleted: {
            onDataChanged();
        }
    }

    Plasmoid.compactRepresentation: Item {
        id: representation
        // Layout.minimumWidth: units.gridUnit
        // Layout.minimumHeight: units.gridUnit

        Component {
            id: programComponent
            Item {
                // width: 0
                height: 60
                Column {
                    Text {
                      color: "#FFFFFF"
                      font.pointSize: 16
                      font.weight: Font.Light
                      text: `${name}`
                    }
                    Text {
                      color: "#FFFFFF"
                      text: `${number}`
                    }
                    PlasmaComponents.ProgressBar {value: progress }
                }
            }
        }

        ListView {
            anchors.fill: parent
            model: dasModel
            delegate: programComponent
        }
    }


    function request(url, callback) {
      var xhr = new XMLHttpRequest()
      xhr.onreadystatechange = function() {
        if(xhr.readyState === 4) {
          callback(JSON.parse(xhr.responseText));
        }
      }
      xhr.open('POST', url, true);
      xhr.setRequestHeader("Content-Type", "application/json");

      var start = new Date();
      start.setHours(0,0,0,0);
      var end = new Date(start.getTime());
      end.setHours(23,59,59,999);

      var data = JSON.stringify({
        "query": [
          "afk_events = query_bucket(find_bucket(\"aw-watcher-afk_\"));",
          "window_events = query_bucket(find_bucket(\"aw-watcher-window_\"));",
          "window_events = filter_period_intersect(window_events, filter_keyvals(afk_events, \"status\", [\"not-afk\"]));",
          "merged_events = merge_events_by_keys(window_events, [\"app\", \"title\"]);",
          "RETURN = sort_by_duration(merged_events);"
        ],
        "timeperiods": [start.toISOString() + '/' + end.toISOString()]
      });
      xhr.send(data);
    }

    function updateData(cb) {
      request('http://localhost:5600/api/0/query/', (response) => {
        dasModel.clear();
        const maxDuration = response[0][0].duration;
        for (let event of response[0].splice(0, 10)) {
          dasModel.append({
            name: event.data.title,
            number: `${Math.round(event.duration / 60)} Minuten`,
            progress: event.duration / maxDuration
          })
        }
      });
    }
}
