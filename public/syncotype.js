function baselines() {
    var container = document.createElement("div");
    for (var i=0, l=100; i<l; i++) {
        var line = document.createElement("div");
        line.style.height = "1px";
        line.style.width = "100%";
        line.style.background = "red";
        line.style.overflow = "hidden";
        line.style.position = "absolute";
        line.style.top = (i*25) + "px";
        container.appendChild(line);
    }
    document.body.appendChild(container);
    container.style.position = "absolute";
    container.style.top = "-1px";
    container.style.left = "0";
    container.style.width = "100%";
    container.style.opacity = "0.5";
};
window.onload = baselines;