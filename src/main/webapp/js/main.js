/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


let req;
let isIE;
let completeField = document.getElementById("complete-field");;
let completeTable = document.getElementById("complete-table");
let autoRow = document.getElementById("auto-row");

function clientSite() {
    window.location.href = 'clientSite.jsp';
}
function logOut() {
    window.location.href = 'Logout';
}


function init() {
    completeTable.style.top = getElementY(autoRow) + "px";
}
    console.log(completeField);

function doCompletion() {
    var url = "AutoCompleteServlet?action=complete&id=" + encodeURIComponent(completeField.value);
    req = initRequest();
    req.open("GET", url, true);
    req.onreadystatechange = callback;
    req.send(null);

}

function initRequest() {
    if (window.XMLHttpRequest) {
        if (navigator.userAgent.indexOf('MSIE') !== -1) {
            isIE = true;
        }
        return new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        return new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function callback() {
    clearTable();
    if (req.readyState === 4) {
        if (req.status === 200) {
            parseMessages(req.responseXML);
        }
    }
}

function appendComposer(name, id) {
    var row;
    var cell;
    var linkElement;

    if (isIE) {
        completeTable.style.display = 'block';
        row = completeTable.insertRow(completeTable.rows.length);
        cell = row.insertCell(0);
    } else {
        completeTable.style.display = 'table';
        row = document.createElement("tr");
        row.style.background = "#ccc";
        cell = document.createElement("td");
        row.appendChild(cell);
        completeTable.appendChild(row);
    }



    cell.className = "popupCell";
    linkElement = document.createElement("a");
    linkElement.className = "popupItem";


    if (username === 'null' || username === '') {
        document.getElementById("log-in-modal").classList.add("visibility");
        document.getElementById("blur").classList.add("visibility");
    } else {
        linkElement.setAttribute("href", "AutoCompleteServlet?action=lookup&id=" + id);
    }
    linkElement.appendChild(document.createTextNode(name));
    cell.appendChild(linkElement);

}

function clearTable() {
    if (completeTable.getElementsByTagName("tr").length > 0) {
        completeTable.style.display = 'none';
        for (var loop = completeTable.childNodes.length - 1; loop >= 0; loop--) {
            completeTable.removeChild(completeTable.childNodes[loop]);
        }
    }
}

function getElementY(element) {
    var targetTop = 0;
    if (element.offsetParent) {
        while (element.offsetParent) {
            targetTop += element.offsetTop;
            element = element.offsetParent;
        }
    } else if (element.y) {
        targetTop += element.y;
    }

    return targetTop;
}

function parseMessages(responseXML) {
    if (responseXML === null) {
        return false;
    } else {


        var products = responseXML.getElementsByTagName("products")[0];
        if (products.childNodes.length > 0) {
            completeTable.setAttribute("bordercolor", "black");
            completeTable.setAttribute("border", "1");
            for (var loop = 0; loop < products.childNodes.length; loop++) {
                var product = products.childNodes[loop];
                var name = product.getElementsByTagName("name")[0];
                var id = product.getElementsByTagName("id")[0];
                appendComposer(
                        name.childNodes[0].nodeValue,
                        id.childNodes[0].nodeValue);

            }
        }
    }
}
