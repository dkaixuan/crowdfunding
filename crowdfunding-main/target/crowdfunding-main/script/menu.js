function showMenu() {

    var pathname=window.location.pathname;
    var contextPath="${APP_PATH}";
    var pathaddress=pathname.substring(contextPath.length);
    var alink=$(".list-group a[href*='"+pathaddress+"']")
    alink.css("color", "red");
    alink.parent().parent().parent().removeClass("tree-closed")
    alink.parent().parent().show();

}