<%@Language="VBScript" CodePage="65001"%>
<!--#include file = "packer.asp" -->
<%

  Option Explicit

  Response.Charset = "utf-8"

  Dim MuseumsArr(17,2), MuseumsArrStr, ManhattanLatLng, JavaScript, x

  ManhattanLatLng = "40.78426,-73.96545"

  MuseumsArr(0,0) = "Nicholas Roerich Museum"
  MuseumsArr(0,1) = 40.80248
  MuseumsArr(0,2) = -73.96906

  MuseumsArr(1,0) = "El Museo del Barrio"
  MuseumsArr(1,1) = 40.79330
  MuseumsArr(1,2) = -73.95137

  MuseumsArr(2,0) = "Museum of the City of New York"
  MuseumsArr(2,1) = 40.79250
  MuseumsArr(2,2) = -73.95194

  MuseumsArr(3,0) = "The Jewish Museum"
  MuseumsArr(3,1) = 40.78542
  MuseumsArr(3,2) = -73.95731

  MuseumsArr(4,0) = "Solomon R. Guggenheim Museum"
  MuseumsArr(4,1) = 40.78296
  MuseumsArr(4,2) = -73.95910

  MuseumsArr(5,0) = "Neue Galerie New York"
  MuseumsArr(5,1) = 40.78123
  MuseumsArr(5,2) = -73.96048

  MuseumsArr(6,0) = "The Metropolitan Museum of Art"
  MuseumsArr(6,1) = 40.77951
  MuseumsArr(6,2) = -73.96316

  MuseumsArr(7,0) = "New-York Historical Society"
  MuseumsArr(7,1) = 40.77939
  MuseumsArr(7,2) = -73.97382

  MuseumsArr(8,0) = "American Museum of Natural History"
  MuseumsArr(8,1) = 40.78129
  MuseumsArr(8,2) = -73.97382

  MuseumsArr(9,0) = "Children's Museum Of Manhattan"
  MuseumsArr(9,1) = 40.78597
  MuseumsArr(9,2) = -73.97741

  MuseumsArr(10,0) = "American Folk Art Museum"
  MuseumsArr(10,1) = 40.77323
  MuseumsArr(10,2) = -73.98145

  MuseumsArr(11,0) = "Museum of Arts and Design"
  MuseumsArr(11,1) = 40.76738
  MuseumsArr(11,2) = -73.98213

  MuseumsArr(12,0) = "SPYSCAPE"
  MuseumsArr(12,1) = 40.76524
  MuseumsArr(12,2) = -73.98377

  MuseumsArr(13,0) = "Intrepid Sea, Air & Space Museum"
  MuseumsArr(13,1) = 40.76459
  MuseumsArr(13,2) = -73.99982

  MuseumsArr(14,0) = "The Museum of Broadway"
  MuseumsArr(14,1) = 40.75757
  MuseumsArr(14,2) = -73.98454

  MuseumsArr(15,0) = "Madame Tussauds New York"
  MuseumsArr(15,1) = 40.75633
  MuseumsArr(15,2) = -73.98874

  MuseumsArr(16,0) = "Mount Vernon Hotel Museum & Garden"
  MuseumsArr(16,1) = 40.76056
  MuseumsArr(16,2) = -73.95973

  MuseumsArr(17,0) = "The Museum of Modern Art"
  MuseumsArr(17,1) = 40.76127
  MuseumsArr(17,2) = -73.97767

  For x = 0 To Ubound(MuseumsArr)

    MuseumsArrStr = MuseumsArrStr & "{lat:" & MuseumsArr(x,1) &_ 
    ",lng:" & MuseumsArr(x,2) &_ 
    ",title:""" & MuseumsArr(x,0) & """}"

    If NOT x = Ubound(MuseumsArr) Then MuseumsArrStr = MuseumsArrStr & ","

  Next

  JavaScript = VBlf & VBlf &_
  "	var atms = [" & MuseumsArrStr & "];" & VBlf &_
  "	var atmIcon = L.icon({" & VBlf &_
  "		iconUrl: ""https://i.ibb.co/JcNNZ1t/museum.png""," & VBlf &_
  "		iconSize: [35, 48]" & VBlf &_
  "	});" & VBlf &_
  "	var pins = L.layerGroup();" & VBlf &_
  "	var bounds = [];" & VBlf &_
  "	for (var i = 0; i < atms.length; i++) {" & VBlf &_
  "		L.marker(" & VBlf &_
  "			[atms[i].lat, atms[i].lng], {" & VBlf &_
  "				icon: atmIcon" & VBlf &_
  "			}" & VBlf &_
  "		).bindPopup(""<h3>"" + atms[i].title + ""</h3>"", {" & VBlf &_
  "			closeButton: !1" & VBlf &_
  "		}).addTo(pins);" & VBlf &_
  "		bounds.push([atms[i].lat,atms[i].lng])" & VBlf &_
  "	}" & VBlf &_
  "	L.map(""map"",{" & VBlf &_
  "		center: [" & ManhattanLatLng & "]," & VBlf &_
  "		zoom: 15," & VBlf &_
  "		layers: [L.tileLayer(""https://tile.openstreetmap.org/{z}/{x}/{y}.png"",{" & VBlf &_
  "			attribution: ""&copy; <a href='https://www.openstreetmap.org/copyright' target='_blank'>OpenStreetMap</a> " & Year(Now()) & """" & VBlf &_
  "		}),pins]" & VBlf &_
  "	}).fitBounds(bounds);" & VBlf & VBlf

  JavaScript = Pack(JavaScript,62,True,False)

%><!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>OpenStreetMap</title>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.3/dist/leaflet.css" integrity="sha256-kLaT2GOSpHechhsozzB+flnD+zUyjE2LlfWPgU04xyI=" crossorigin="" />
<style>
*{
    margin: 0;
    padding: 0;
}
#map{
    width: 100%;
    height: 100vh;
}
</style>
</head>
<body>
<div id="map"></div>
<script src="https://unpkg.com/leaflet@1.9.3/dist/leaflet.js" integrity="sha256-WBkoXOwTeyKclOHuWtc+i2uENFpDZ9YPdf5Hf+D7ewM=" crossorigin=""></script>
<script><%=JavaScript%></script>
</body>
</html>
