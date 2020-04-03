//.pragma library
.import QtQuick.LocalStorage 2.0 as Storage
.import "Common.js" as Js
/* ****************************************************************************
 * Database.js
 * Written by Jeffrey Scott Flesher
 */
/* ****************************************************************************
 * get set DbName
 */
var DbName = "GalaxyCalculator2";
function getDbName() {
    return DbName;
}
function setDbName(dbName) {
    DbName = dbName;
}
/* ****************************************************************************
 * get set DbDescription
 */
var DbDescription = "Galaxy Calculator";
function getDbDescription() {
    return DbDescription;
}
function setDbDescription(dbDescription) {
    DbDescription = dbDescription;
}
/* ****************************************************************************
 * get set DbVersion
 */
var DbVersion = "1.0";
function getDbVersion() {
    return DbVersion;
}
function setDbVersion(dbVersion) {
    DbVersion = dbVersion;
}
/* ****************************************************************************
 * get set TextEditGalaxy
 * Default:
 */
var TextEditGalaxy = "Milky Way";
function getTextEditGalaxy() {
    return TextEditGalaxy;
}
function setTextEditGalaxy(textEditGalaxy) {
    TextEditGalaxy = textEditGalaxy;
}
/* ****************************************************************************
 * get set TextEditSunSize
 * Default:
 */
var TextEditSunSize = "864575.9";
function getTextEditSunSize() {
    return TextEditSunSize;
}
function setTextEditSunSize(textEditSunSize) {
    TextEditSunSize = textEditSunSize;
}
/* ****************************************************************************
 * get set TextEditLivalbePlanetSize
 * Default:
 */
var TextEditLivalbePlanetSize = "7926.2109";
function getTextEditLivalbePlanetSize() {
    return TextEditLivalbePlanetSize;
}
function setTextEditLivalbePlanetSize(textEditLivalbePlanetSize) {
    TextEditLivalbePlanetSize = textEditLivalbePlanetSize;
}
/* ****************************************************************************
 * get set TextEditTrinaryEngines
 * Default:
 */
var TextEditTrinaryEngines = "333";
function getTextEditTrinaryEngines() {
    return TextEditTrinaryEngines;
}
function setTextEditTrinaryEngines(textEditTrinaryEngines) {
    TextEditTrinaryEngines = textEditTrinaryEngines;
}
/* ****************************************************************************
 * get set TextEditGalaxyRadius
 * Default:
 */
var TextEditGalaxyRadius = "241828072282107.5071453596951";
function getTextEditGalaxyRadius() {
    return TextEditGalaxyRadius;
}
function setTextEditGalaxyRadius(textEditGalaxyRadius) {
    TextEditGalaxyRadius = textEditGalaxyRadius;
}
/* ****************************************************************************
 * get set TextEditPrintNthTrack
 * Default:
 */
var TextEditPrintNthTrack = "66";
function getTextEditPrintNthTrack() {
    return TextEditPrintNthTrack;
}
function setTextEditPrintNthTrack(textEditPrintNthTrack) {
    TextEditPrintNthTrack = textEditPrintNthTrack;
}
/* ****************************************************************************
 * get set RecordNumber
 * Default:
 */
var RecordNumber = "";
function getRecordNumber() {
    return RecordNumber;
}
function setRecordNumber(recordNumber) {
    RecordNumber = recordNumber;
}
/* ****************************************************************************
 * set Defaults
 */
function setConfiguration(textEditGalaxy, textEditSunSize, textEditLivalbePlanetSize, textEditTrinaryEngines, textEditGalaxyRadius, textEditPrintNthTrack, recordNumber) {
    setTextEditGalaxy(textEditGalaxy)
    setTextEditSunSize(textEditSunSize);
    setTextEditLivalbePlanetSize(textEditLivalbePlanetSize);
    setTextEditTrinaryEngines(textEditTrinaryEngines);
    setTextEditGalaxyRadius(textEditGalaxyRadius);
    setTextEditPrintNthTrack(textEditPrintNthTrack);
    setRecordNumber(recordNumber);
}
/* ****************************************************************************
 * get set Galaxy
 * Default:
 */
var Galaxy = "Milky Way";
function getGalaxy() {
    return Galaxy;
}
function setGalaxy(galaxy) {
    Galaxy = galaxy;
}
/* ****************************************************************************
 * get set SunSize
 * Size in Diameter in Miles
 * Default: Our Solar Systems or World
 */
var SunSize = "864575.9";
function getSunSize() {
    return SunSize;
}
function setSunSize(sunSize) {
    SunSize = sunSize;
}
/* ****************************************************************************
 * get set livalbePlanetSize
 * Size in Diameter in Miles
 * Default: Earth
 */
var LivalbePlanetSize = "7926.2109";
function getLivalbePlanetSize() {
    return LivalbePlanetSize;
}
function setLivalbePlanetSize(livalbePlanetSize) {
    LivalbePlanetSize = livalbePlanetSize;
}
/* ****************************************************************************
 * get set trinaryEngines
 * Default:
 */
var TrinaryEngines = "333";
function getTrinaryEngines() {
    return TrinaryEngines;
}
function setTrinaryEngines(trinaryEngines) {
    TrinaryEngines = trinaryEngines;
}
/* ****************************************************************************
 * get set galaxyRadius
 * Radius in Miles
 * Default: Milkey Way
 */
var GalaxyRadius = "241828072282107.5071453596951";
function getGalaxyRadius() {
    return GalaxyRadius;
}
function setGalaxyRadius(galaxyRadius) {
    GalaxyRadius = galaxyRadius;
}
/* ****************************************************************************
 * get set printNthTrack
 * Number of tracks to skip: 1 = Print All, 66 = Every 66th Track: about 42
 * Default: 66
 */
var PrintNthTrack = "66";
function getPrintNthTrack() {
    return PrintNthTrack;
}
function setPrintNthTrack(printNthTrack) {
    PrintNthTrack = printNthTrack;
}
/* ****************************************************************************
 * setConfig
 */
function setConfig(galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack) {
    setGalaxy(galaxy);
    setSunSize(sunSize);
    setLivalbePlanetSize(livalbePlanetSize);
    setTrinaryEngines(trinaryEngines);
    setGalaxyRadius(galaxyRadius);
    setPrintNthTrack(printNthTrack);
}
/* ****************************************************************************
 * dbInit
 */
function dbInit() {
    var db = Storage.LocalStorage.openDatabaseSync(getDbName(), getDbVersion(), getDbDescription(), 1000000);
    // Create the database if it doesn't already exist
    try {
        db.transaction(function (tx) {
            tx.executeSql(
                'CREATE TABLE IF NOT EXISTS configuration ([rowid] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,[galaxy] TEXT,[sunSize] TEXT,[livalbePlanetSize] TEXT,[trinaryEngines] TEXT,[galaxyRadius] TEXT,[printNthTrack] TEXT)');
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    }
    // Create the database if it doesn't already exist
    try {
        db.transaction(function (tx) {
            tx.executeSql(
                'CREATE TABLE IF NOT EXISTS galaxyTracks ([rowid] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,[currentTrackNumber] TEXT,[trackEngines] TEXT,[maxSpeed] TEXT,[minSpeed] TEXT,[lpFrequency] TEXT,[orbitDist] TEXT,[trackFreq] TEXT)');
        });
    } catch (err2) {
        console.log("Error creating table in database: " + err2);
    }
    // Create the database if it doesn't already exist
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS settings(setting TEXT UNIQUE, value TEXT)');
        });
    } catch (err3) {
        console.log("Error creating table in database: " + err3);
    }
}
/* ****************************************************************************
 * dbGetHandle
 */
function dbGetHandle() {
    try {
        var db = Storage.LocalStorage.openDatabaseSync(getDbName(), getDbVersion(), getDbDescription(), 1000000);
    } catch (err) {
        console.log("Error opening database: " + dbName + " error: " + err);
    }
    return db
}
/* ****************************************************************************
 * dbDeleteGalaxyTracks
 */
function dbDeleteGalaxyTracks() {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM galaxyTracks');
    });
}
/* ****************************************************************************
 * setModel
 */
function setModel(orderBy, direction) {
    dbReadAllGalxyCalculations(orderBy, direction);
    appListViewGalaxyCalculator.model = listModelGalxyCalculator;
    appListViewGalaxyCalculator.update();
}
/* ****************************************************************************
 * Table: configuration
 * 0: galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack
 * 1: galaxy
 * 2: sunSize
 * 3: livalbePlanetSize
 * 4: trinaryEngines
 * 5: galaxyRadius
 * 6: printNthTrack
 */
function dbInsertConfiguration(galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack) {
    if (Js.getIsDebugMessage()) {
        console.debug("dbInsertConfiguration(galaxy=" + galaxy + ", sunSize=" + sunSize + ", livalbePlanetSize=" + livalbePlanetSize + ", trinaryEngines=" + trinaryEngines + ", galaxyRadius=" + galaxyRadius + ", printNthTrack=" + printNthTrack + ")");
    }
    var db = dbGetHandle();
    var rowid = 0;
    // INSERT INTO configuration (galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius, printNthTrack) VALUES(?, ?, ?, ?, ?, ?), ['Milky Way',864575.9,7926.2109,333,241828072282107.5071453596951,66]
    db.transaction(function (tx) {
        if (Js.getIsDebugMessage()) {
            console.debug("INSERT INTO configuration (galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius,  printNthTrack) VALUES(?, ?, ?, ?, ?, ?), ['" + galaxy + "'," + sunSize + "," + livalbePlanetSize + "," + trinaryEngines + "," + galaxyRadius + ",'"  + printNthTrack + "]");
        }
        tx.executeSql('INSERT INTO configuration (galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius,  printNthTrack) VALUES(?, ?, ?, ?, ?, ?)',
                      [galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius, printNthTrack]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    });
    dbReadAllConfigurations();
    return rowid;
}
/* ****************************************************************************
 * Table: galaxyTracks
 * 0: currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq
 * 1: currentTrackNumber
 * 2: trackEngines
 * 3: maxSpeed
 * 4: minSpeed
 * 5: lpFrequency
 * 6: orbitDist
 * 7: trackFreq
 */
function dbInsertGalaxyTrack(currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq) {
    var db = dbGetHandle();
    var rowid = 0;
    if (Js.getIsDebugMessage()) {
        console.debug("dbInsertGalaxyTrack(currentTrackNumber=" + currentTrackNumber + ", trackEngines=" + trackEngines + ", maxSpeed=" + maxSpeed + ", minSpeed=" + minSpeed + ", lpFrequency=" + lpFrequency + ", orbitDist=" + orbitDist + ", trackFreq=" + trackFreq + ")");
    }
    db.transaction(function (tx) {
        tx.executeSql(
            'INSERT INTO galaxyTracks (currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq) VALUES(?, ?, ?, ?, ?, ?, ?)',
            [currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq]);
        var result = tx.executeSql('SELECT last_insert_rowid()');
        rowid = result.insertId;
    });
    setModel("rowid", "ASC");
    return rowid;
}
/* ****************************************************************************
 * Table: configuration
 * 0: galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack
 * 1: galaxy
 * 2: sunSize
 * 3: livalbePlanetSize
 * 4: trinaryEngines
 * 5: galaxyRadius
 * 6: printNthTrack
 *
 */
function dbReadAllConfigurations() {
    // get Database Handle
    var db = dbGetHandle();
    // clear listModel
    if (Js.getIsDebugMessage()) {
        console.debug("SELECT rowid, galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius, printNthTrack FROM configuration order by rowid desc")
    }
    listModelConfiguration.clear();
    db.transaction(function (tx) {
        var i;
        var results = tx.executeSql(
            'SELECT rowid, galaxy, sunSize, livalbePlanetSize, trinaryEngines, galaxyRadius, printNthTrack FROM configuration order by rowid desc');
        for (i = 0; i < results.rows.length; i++) {
            if (Js.getIsDebugMessage()) {
                console.debug("id=" + results.rows.item(i).rowid + " galaxy: " + results.rows.item(i).galaxy);
            }
            listModelConfiguration.append({
                galaxy: results.rows.item(i).galaxy,
            });
        } // end for
        for (i = 0; i < results.rows.length; i++) {
            if (Js.getIsDebugMessage()) {
                console.debug("id=" + results.rows.item(i).rowid + " galaxy: " + results.rows.item(i).galaxy);
            }
            listModelConfigurationDb.append({
                // Name change id rowid
                rowid: results.rows.item(i).rowid,
                galaxy: results.rows.item(i).galaxy,
                sunSize: results.rows.item(i).sunSize,
                livalbePlanetSize: results.rows.item(i).livalbePlanetSize,
                trinaryEngines: results.rows.item(i).trinaryEngines,
                galaxyRadius: results.rows.item(i).galaxyRadius,
                printNthTrack: results.rows.item(i).printNthTrack
            });
        } // end for
        if (Js.getIsDebugMessage()) {
            console.debug("listModelConfiguration.count=" + listModelConfiguration.count)
            console.debug("listModelConfigurationDb.count=" + listModelConfigurationDb.count)
        }
    });
}
/* ****************************************************************************
 * Table: galaxyTracks
 * 0: currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq
 * 1: currentTrackNumber
 * 2: trackEngines
 * 3: maxSpeed
 * 4: minSpeed
 * 5: lpFrequency
 * 6: orbitDist
 * 7: trackFreq
 * direction= DESC ASC
 */
function dbReadAllGalxyCalculations(orderBy, direction) {
    var db = dbGetHandle();
    listModelGalxyCalculator.clear();
    if (Js.getIsDebugMessage()) {
        console.debug("sql=" + "SELECT rowid,currentTrackNumber,trackEngines,maxSpeed,minSpeed,lpFrequency,orbitDist,trackFreq FROM galaxyTracks ORDER BY " + orderBy + " " + direction)
    }
    db.transaction(function (tx) {
        var results = tx.executeSql(
            "SELECT rowid,currentTrackNumber,trackEngines,maxSpeed,minSpeed,lpFrequency,orbitDist,trackFreq FROM galaxyTracks ORDER BY " + orderBy + " " + direction);
        for (var i = 0; i < results.rows.length; i++) {
            if (Js.getIsDebugMessage()) {
                console.debug("id=" + results.rows.item(i).rowid + " currentTrackNumber: " + results.rows.item(i).currentTrackNumber);
            }
            listModelGalxyCalculator.append({
                rowid: results.rows.item(i).rowid,
                currentTrackNumber: results.rows.item(i).currentTrackNumber,
                trackEngines: results.rows.item(i).trackEngines,
                maxSpeed: results.rows.item(i).maxSpeed,
                minSpeed: results.rows.item(i).minSpeed,
                lpFrequency: results.rows.item(i).lpFrequency,
                orbitDist: results.rows.item(i).orbitDist,
                trackFreq: results.rows.item(i).trackFreq
            });
        } // end for
    })
}
/* ****************************************************************************
 * Table: configuration
 * 0: galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack
 * 1: galaxy
 * 2: sunSize
 * 3: livalbePlanetSize
 * 4: trinaryEngines
 * 5: galaxyRadius
 * 6: printNthTrack
 *
 */
function dbUpdateConfiguration(galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack,rowid) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
            'update configuration set galaxy=?, sunSize=?, livalbePlanetSize=?, trinaryEngines=?, galaxyRadius=?, printNthTrack=? where rowid = ?', [galaxy,sunSize,livalbePlanetSize,trinaryEngines,galaxyRadius,printNthTrack,rowid])
    });
    dbReadAllConfigurations();
}
/* ****************************************************************************
 * Table: galaxyTracks
 * 0: currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq
 * 1: currentTrackNumber
 * 2: trackEngines
 * 3: maxSpeed
 * 4: minSpeed
 * 5: lpFrequency
 * 6: orbitDist
 * 7: trackFreq
 *
 */
function dbUpdateGalaxyTracks(currentTrackNumber, trackEngines, maxSpeed, minSpeed, lpFrequency, orbitDist, trackFreq,Prowid) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
            'update galaxyTracks set currentTrackNumber=?, trackEngines=?, maxSpeed=?, minSpeed=?, lpFrequency=?, orbitDist=?, trackFreq=? where rowid = ?', [currentTrackNumber,trackEngines,maxSpeed,minSpeed,lpFrequency,orbitDist,trackFreq,Prowid])
    });
    setModel("rowid", "ASC");
}
/* ****************************************************************************
 * dbDeleteRowConfiguration
 */
function dbDeleteRowConfiguration(Prowid) {
    var db = dbGetHandle();
    db.transaction(function (tx) {
        tx.executeSql(
            'delete from configuration where rowid = ?', [Prowid])
    });
    dbReadAllConfigurations();
}
/* ****************************************************************************
 * dbDeleteRowGalaxyTracks
 */
function dbDeleteRowGalaxyTracks(Prowid) {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('delete from galaxyTracks where rowid = ?', [Prowid])
    });
    setModel("rowid", "ASC");
}
/* ****************************************************************************
 * getDbSetting
 */
function getDbSetting(fieldName, defaultValue) {
    var tempSetting = app.settings.getValue(fieldName);
    if(tempSetting === undefined) {
        tempSetting = defaultValue;
    }
    if(tempSetting === "") {
        tempSetting = defaultValue;
    }
    app.settings.setValue(fieldName, tempSetting);
    return tempSetting;
} // end getDbSetting
/* ****************************************************************************
 * setDbSetting
 */
function setDbSetting(fieldName, theValue) {
    app.settings.setValue(fieldName, theValue);
} // end setDbSetting
/* ****************************************************************************
 * set
 */
function set(setting, value) {
   var db = dbGetHandle();
   var res = "";
   db.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO settings VALUES (?,?);', [setting,value]);
              if (rs.rowsAffected > 0) {
                res = "OK";
              } else {
                res = "Error";
              }
        }
  );
  return res;
}
/* ****************************************************************************
 * get
 */
function get(setting, default_value) {
   var db = dbGetHandle();
   var res="";
   try {
       db.transaction(function(tx) {
         var rs = tx.executeSql('SELECT value FROM settings WHERE setting=?;', [setting]);
         if (rs.rows.length > 0) {
              res = rs.rows.item(0).value;
         } else {
             res = default_value;
         }
      })
   } catch (err) {
       //console.log("Database " + err);
       res = default_value;
   };
  return res
}
/* ****************************************************************************
 *
 */

/* ***************************** End of File ******************************* */
