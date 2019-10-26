function creatXMLHttpRequest() {
    try {
        return new XMLHttpRequest();//大多数浏览器
    } catch (e) {
        try {
            return ActiveXObject("Msxml2.XMLHTTP");//IE6.0
        } catch (e) {
            try {
                return ActiveXObject("Microsoft.XMLHTTP");//IE5.5以及更早版本
            } catch (e) {
                alert("您的浏览器不支持，请更换Chrome浏览器！")
                throw e;
            }
        }
    }
}

