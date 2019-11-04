

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer">
    <p>&copy; 2019 Company, Inc.</p>
</footer>
</div> <!-- /container -->
<script type="text/javascript">function is_exit() {
document.getElementById("formid").submit();
}
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
</script>

<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="/bootstrap-3.3.7-dist/assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>