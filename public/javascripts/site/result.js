function parametros(){
    var result = document.getElementById("result");
    result.style.display = "block";
    var largura = result.offsetWidth;
    result.style.marginLeft = -(largura / 2)+"px";
}
function hide(){
    var elemento = new Tween(document.getElementById('result').style,'top',Tween.regularEaseInOut,0,-400,1,'px');
    elemento.start();
}
function show(){
    parametros();
    var elemento = new Tween(document.getElementById('result').style,'top',Tween.regularEaseInOut,-400,0,1,'px');
    elemento.start();
}
