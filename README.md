# ClassicASP.JS.Packer
This is Dean Edwards /packer/ (a JavaScript compressor) written in JScript and compatible with VBScript in Classic ASP.

JScript is Microsoft's legacy dialect of the ECMAScript standard; it should not be confused with JavaScript. JScript can run server-side in .asp pages and is compatible with .asp pages written in VBScript. JScript is similar to JavaScript, but much more limited. As a result, this version of Dean Edwards /packer/ is v1.1 (the latest and final version is 3.0).

Not only is this is a very useful JavaScript compressor, it's also a great JavaScript obfuscator, meaning it can take JavaScript code and make it very difficult to read. This can help protect against data scraping. For example, if you've paid for geographical data and wish to implement it in a project such as OpenStreetMap, you need to use JavaScript, but ideally you don't want the raw data easily readable in the source code.

Below I will demonstrate this with an OpenStreetMap example that uses longitude/latitude data to pin museums in Manhattan.

![museums in Manhattan](https://i.ibb.co/ZHn59P0/museum.jpg)

## OpenStreetMap Example

First, let's look at the uncompressed JavaScript output.

**NOTE:** I'm using a 2D array for demonstration purposes as appose to retrieving data from a database backend.

    <%@Language="VBScript" CodePage="65001"%>
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
      "	var museums = [" & MuseumsArrStr & "];" & VBlf &_
      "	var museumIcon = L.icon({" & VBlf &_
      "		iconUrl: ""https://i.ibb.co/JcNNZ1t/museum.png""," & VBlf &_
      "		iconSize: [35, 48]" & VBlf &_
      "	});" & VBlf &_
      "	var pins = L.layerGroup();" & VBlf &_
      "	var bounds = [];" & VBlf &_
      "	for (var i = 0; i < museums.length; i++) {" & VBlf &_
      "		L.marker(" & VBlf &_
      "			[museums[i].lat, museums[i].lng], {" & VBlf &_
      "				icon: museumIcon" & VBlf &_
      "			}" & VBlf &_
      "		).bindPopup(""<h3>"" + museums[i].title + ""</h3>"", {" & VBlf &_
      "			closeButton: !1" & VBlf &_
      "		}).addTo(pins);" & VBlf &_
      "		bounds.push([museums[i].lat,museums[i].lng])" & VBlf &_
      "	}" & VBlf &_
      "	L.map(""map"",{" & VBlf &_
      "		center: [" & ManhattanLatLng & "]," & VBlf &_
      "		zoom: 15," & VBlf &_
      "		layers: [L.tileLayer(""https://tile.openstreetmap.org/{z}/{x}/{y}.png"",{" & VBlf &_
      "			attribution: ""&copy; <a href='https://www.openstreetmap.org/copyright' target='_blank'>OpenStreetMap</a> " & Year(Now()) & """" & VBlf &_
      "		}),pins]" & VBlf &_
      "	}).fitBounds(bounds);" & VBlf & VBlf

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
    
The HTML output:

    <!DOCTYPE html>
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
    <script>

      var museums = [{lat:40.80248,lng:-73.96906,title:"Nicholas Roerich Museum"},{lat:40.7933,lng:-73.95137,title:"El Museo del Barrio"},{lat:40.7925,lng:-73.95194,title:"Museum of the City of New York"},{lat:40.78542,lng:-73.95731,title:"The Jewish Museum"},{lat:40.78296,lng:-73.9591,title:"Solomon R. Guggenheim Museum"},{lat:40.78123,lng:-73.96048,title:"Neue Galerie New York"},{lat:40.77951,lng:-73.96316,title:"The Metropolitan Museum of Art"},{lat:40.77939,lng:-73.97382,title:"New-York Historical Society"},{lat:40.78129,lng:-73.97382,title:"American Museum of Natural History"},{lat:40.78597,lng:-73.97741,title:"Children's Museum Of Manhattan"},{lat:40.77323,lng:-73.98145,title:"American Folk Art Museum"},{lat:40.76738,lng:-73.98213,title:"Museum of Arts and Design"},{lat:40.76524,lng:-73.98377,title:"SPYSCAPE"},{lat:40.76459,lng:-73.99982,title:"Intrepid Sea, Air & Space Museum"},{lat:40.75757,lng:-73.98454,title:"The Museum of Broadway"},{lat:40.75633,lng:-73.98874,title:"Madame Tussauds New York"},{lat:40.76056,lng:-73.95973,title:"Mount Vernon Hotel Museum & Garden"},{lat:40.76127,lng:-73.97767,title:"The Museum of Modern Art"}];
      var museumIcon = L.icon({
        iconUrl: "https://i.ibb.co/JcNNZ1t/museum.png",
        iconSize: [35, 48]
      });
      var pins = L.layerGroup();
      var bounds = [];
      for (var i = 0; i < museums.length; i++) {
        L.marker(
          [museums[i].lat, museums[i].lng], {
            icon: museumIcon
          }
        ).bindPopup("<h3>" + museums[i].title + "</h3>", {
          closeButton: !1
        }).addTo(pins);
        bounds.push([museums[i].lat,museums[i].lng])
      }
      L.map("map",{
        center: [40.78426,-73.96545],
        zoom: 15,
        layers: [L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png",{
          attribution: "&copy; <a href='https://www.openstreetmap.org/copyright' target='_blank'>OpenStreetMap</a> 2023"
        }),pins]
      }).fitBounds(bounds);

    </script>
    </body>
    </html>
    
Now let's include "packer.asp", and pack the JavaScript using the default configuration:

**NOTE:** A detailed explanation of the "Pack" function parameters can be found in "packer.asp".

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
      "	var museums = [" & MuseumsArrStr & "];" & VBlf &_
      "	var museumIcon = L.icon({" & VBlf &_
      "		iconUrl: ""https://i.ibb.co/JcNNZ1t/museum.png""," & VBlf &_
      "		iconSize: [35, 48]" & VBlf &_
      "	});" & VBlf &_
      "	var pins = L.layerGroup();" & VBlf &_
      "	var bounds = [];" & VBlf &_
      "	for (var i = 0; i < museums.length; i++) {" & VBlf &_
      "		L.marker(" & VBlf &_
      "			[museums[i].lat, museums[i].lng], {" & VBlf &_
      "				icon: museumIcon" & VBlf &_
      "			}" & VBlf &_
      "		).bindPopup(""<h3>"" + museums[i].title + ""</h3>"", {" & VBlf &_
      "			closeButton: !1" & VBlf &_
      "		}).addTo(pins);" & VBlf &_
      "		bounds.push([museums[i].lat,museums[i].lng])" & VBlf &_
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
    
The HTML output:

	<!DOCTYPE html>
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
	<script>eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){var c,d,e,k;while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('b 8=[{3:5.2g,2:-4.2f,6:"2e 2d 7"},{3:5.2c,2:-4.2b,6:"2a 29 28 27"},{3:5.26,2:-4.25,6:"7 9 24 23 9 e d"},{3:5.22,2:-4.21,6:"c 20 7"},{3:5.1Z,2:-4.1Y,6:"1X R. 1W 7"},{3:5.1V,2:-4.1U,6:"1T 1S e d"},{3:5.1R,2:-4.1Q,6:"c 1P 7 9 j"},{3:5.1O,2:-4.t,6:"e-d 1N 1M"},{3:5.1L,2:-4.t,6:"r 7 9 1K 1J"},{3:5.1I,2:-4.1H,6:"1G\'s 7 1F 1E"},{3:5.1D,2:-4.1C,6:"r 1B j 7"},{3:5.1A,2:-4.1z,6:"7 9 1y 1x 1w"},{3:5.1v,2:-4.1u,6:"1t"},{3:5.1s,2:-4.1r,6:"1q 1p, 1o & 1n 7"},{3:5.1m,2:-4.1l,6:"c 7 9 1k"},{3:5.1j,2:-4.1i,6:"1h 1g e d"},{3:5.1f,2:-4.1e,6:"1d 1c 1b 7 & 1a"},{3:5.19,2:-4.18,6:"c 7 9 17 j"}];b p=L.q({16:"h://i.14.13/12/11.m",10:[Z,Y]});b g=L.X();b f=[];W(b i=0;i<8.V;i++){L.U([8[i].3,8[i].2],{q:p}).T("<o>"+8[i].6+"</o>",{S:!1}).Q(g);f.P([8[i].3,8[i].2])}L.n("n",{O:[5.N,-4.M],K:15,J:[L.I("h://H.l.k/{z}/{x}/{y}.m",{G:"&F; <a E=\'h://D.l.k/C\' B=\'A\'>w</a> v"}),g]}).u(f);',62,141,'||lng|lat|73|40|title|Museum|museums|of||var|The|York|New|bounds|pins|https||Art|org|openstreetmap|png|map|h3|museumIcon|icon|American||97382|fitBounds|2023|OpenStreetMap||||_blank|target|copyright|www|href|copy|attribution|tile|tileLayer|layers|zoom||96545|78426|center|push|addTo||closeButton|bindPopup|marker|length|for|layerGroup|48|35|iconSize|museum|JcNNZ1t|co|ibb||iconUrl|Modern|97767|76127|Garden|Hotel|Vernon|Mount|95973|76056|Tussauds|Madame|98874|75633|Broadway|98454|75757|Space|Air|Sea|Intrepid|99982|76459|SPYSCAPE|98377|76524|Design|and|Arts|98213|76738|Folk|98145|77323|Manhattan|Of|Children|97741|78597|History|Natural|78129|Society|Historical|77939|Metropolitan|96316|77951|Galerie|Neue|96048|78123|Guggenheim|Solomon|9591|78296|Jewish|95731|78542|City|the|95194|7925|Barrio|del|Museo|El|95137|7933|Roerich|Nicholas|96906|80248'.split('|'),0,{}));</script>
	</body>
	</html>
    
This is the compressed and obfuscated JavaScript:

> eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){var c,d,e,k;while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('b 8=[{3:5.2g,2:-4.2f,6:"2e 2d 7"},{3:5.2c,2:-4.2b,6:"2a 29 28 27"},{3:5.26,2:-4.25,6:"7 9 24 23 9 e d"},{3:5.22,2:-4.21,6:"c 20 7"},{3:5.1Z,2:-4.1Y,6:"1X R. 1W 7"},{3:5.1V,2:-4.1U,6:"1T 1S e d"},{3:5.1R,2:-4.1Q,6:"c 1P 7 9 j"},{3:5.1O,2:-4.t,6:"e-d 1N 1M"},{3:5.1L,2:-4.t,6:"r 7 9 1K 1J"},{3:5.1I,2:-4.1H,6:"1G\'s 7 1F 1E"},{3:5.1D,2:-4.1C,6:"r 1B j 7"},{3:5.1A,2:-4.1z,6:"7 9 1y 1x 1w"},{3:5.1v,2:-4.1u,6:"1t"},{3:5.1s,2:-4.1r,6:"1q 1p, 1o & 1n 7"},{3:5.1m,2:-4.1l,6:"c 7 9 1k"},{3:5.1j,2:-4.1i,6:"1h 1g e d"},{3:5.1f,2:-4.1e,6:"1d 1c 1b 7 & 1a"},{3:5.19,2:-4.18,6:"c 7 9 17 j"}];b p=L.q({16:"h://i.14.13/12/11.m",10:[Z,Y]});b g=L.X();b f=[];W(b i=0;i<8.V;i++){L.U([8[i].3,8[i].2],{q:p}).T("<o>"+8[i].6+"</o>",{S:!1}).Q(g);f.P([8[i].3,8[i].2])}L.n("n",{O:[5.N,-4.M],K:15,J:[L.I("h://H.l.k/{z}/{x}/{y}.m",{G:"&F; <a E=\'h://D.l.k/C\' B=\'A\'>w</a> v"}),g]}).u(f);',62,141,'||lng|lat|73|40|title|Museum|museums|of||var|The|York|New|bounds|pins|https||Art|org|openstreetmap|png|map|h3|museumIcon|icon|American||97382|fitBounds|2023|OpenStreetMap||||_blank|target|copyright|www|href|copy|attribution|tile|tileLayer|layers|zoom||96545|78426|center|push|addTo||closeButton|bindPopup|marker|length|for|layerGroup|48|35|iconSize|museum|JcNNZ1t|co|ibb||iconUrl|Modern|97767|76127|Garden|Hotel|Vernon|Mount|95973|76056|Tussauds|Madame|98874|75633|Broadway|98454|75757|Space|Air|Sea|Intrepid|99982|76459|SPYSCAPE|98377|76524|Design|and|Arts|98213|76738|Folk|98145|77323|Manhattan|Of|Children|97741|78597|History|Natural|78129|Society|Historical|77939|Metropolitan|96316|77951|Galerie|Neue|96048|78123|Guggenheim|Solomon|9591|78296|Jewish|95731|78542|City|the|95194|7925|Barrio|del|Museo|El|95137|7933|Roerich|Nicholas|96906|80248'.split('|'),0,{}));

Here it is encoded using High ASCII (95):

> eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(c/a))+String.fromCharCode(c%a+161)};if(!''.replace(/^/,String)){var c,d,e,k;while(c--)d[e(c)]=k[c]||e(c);k=[function(e){return d[e]}];e=function(){return'[\xa1-\xff]+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp(e(c),'g'),k[c]);return p}('© §=[{¢:¤.¢Ä,¡:-£.¢Ã,¥:"¢Â ¢Á ¦"},{¢:¤.¢À,¡:-£.¢¿,¥:"¢¾ ¢½ ¢¼ ¢»"},{¢:¤.¢º,¡:-£.¢¹,¥:"¦ ¨ ¢¸ ¢· ¨ ¬ «"},{¢:¤.¢¶,¡:-£.¢µ,¥:"ª ¢´ ¦"},{¢:¤.¢³,¡:-£.¢²,¥:"¢± R. ¢° ¦"},{¢:¤.¢¯,¡:-£.¢®,¥:"¢­ ¢¬ ¬ «"},{¢:¤.¢«,¡:-£.¢ª,¥:"ª ¢© ¦ ¨ °"},{¢:¤.¢¨,¡:-£.¹,¥:"¬-« ¢§ ¢¦"},{¢:¤.¢¥,¡:-£.¹,¥:"¸ ¦ ¨ ¢¤ ¢£"},{¢:¤.¢¢,¡:-£.¢¡,¥:"ÿ\'s ¦ þ ý"},{¢:¤.ü,¡:-£.û,¥:"¸ ú ° ¦"},{¢:¤.ù,¡:-£.ø,¥:"¦ ¨ ÷ ö õ"},{¢:¤.ô,¡:-£.ó,¥:"ò"},{¢:¤.ñ,¡:-£.ð,¥:"ï î, í & ì ¦"},{¢:¤.ë,¡:-£.ê,¥:"ª ¦ ¨ é"},{¢:¤.è,¡:-£.ç,¥:"æ å ¬ «"},{¢:¤.ä,¡:-£.ã,¥:"â á à ¦ & ß"},{¢:¤.Þ,¡:-£.Ý,¥:"ª ¦ ¨ Ü °"}];© ¶=L.·({Û:"¯://i.Ú.Ù/Ø/×.³",Ö:[Õ,Ô]});© ®=L.Ó();© ­=[];Ò(© i=0;i<§.Ñ;i++){L.Ð([§[i].¢,§[i].¡],{·:¶}).Ï("<µ>"+§[i].¥+"</µ>",{Î:!1}).Í(®);­.Ì([§[i].¢,§[i].¡])}L.´("´",{Ë:[¤.Ê,-£.É],È:Ç,Æ:[L.Å("¯://Ä.².±/{z}/{x}/{y}.³",{Ã:"&Â; <a Á=\'¯://À.².±/¿\' ¾=\'½\'>¼</a> »"}),®]}).º(­);',95,131,'lng|lat|73|40|title|Museum|museums|of|var|The|York|New|bounds|pins|https|Art|org|openstreetmap|png|map|h3|museumIcon|icon|American|97382|fitBounds|2023|OpenStreetMap|_blank|target|copyright|www|href|copy|attribution|tile|tileLayer|layers|15|zoom|96545|78426|center|push|addTo|closeButton|bindPopup|marker|length|for|layerGroup|48|35|iconSize|museum|JcNNZ1t|co|ibb|iconUrl|Modern|97767|76127|Garden|Hotel|Vernon|Mount|95973|76056|Tussauds|Madame|98874|75633|Broadway|98454|75757|Space|Air|Sea|Intrepid|99982|76459|SPYSCAPE|98377|76524|Design|and|Arts|98213|76738|Folk|98145|77323|Manhattan|Of|Children|97741|78597|History|Natural|78129|Society|Historical|77939|Metropolitan|96316|77951|Galerie|Neue|96048|78123|Guggenheim|Solomon|9591|78296|Jewish|95731|78542|City|the|95194|7925|Barrio|del|Museo|El|95137|7933|Roerich|Nicholas|96906|80248'.split('|'),0,{}));
    
### [Working demo with the OSM JavaScript packed using the default configuration](https://codepen.io/as08/pen/yLqaoYN)
