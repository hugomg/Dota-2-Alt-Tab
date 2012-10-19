
var toggle_ack = document.getElementById('toggleAcks');
var toggle_text = toggle_ack.childNodes[0];
var acks_div   = document.getElementById('acks');

toggle_ack.onclick = function(){
    if(acks_div.className === "hidden"){
        acks_div.className = "";
        toggle_text.nodeValue = "Hide acknowledgements";
    }else{
        acks_div.className = "hidden";
        toggle_text.nodeValue = "Show acknowledgements";
    }
};

var mk_tab_onclick = function(ix, tabs, panes){
    return function(){
        for(var i=0; i<tabs.length; i++){
            var tab = tabs[i];
            tab.className = (i === ix ?  "tab active" : "tab inactive")
        }
        
        for(var i=0; i<panes.length; i++){
            var pane = panes[i];
            pane.className = (i === ix ?  "pane visible" : "pane hidden")
        }
    }
};

var init_tabs = function(){
    var divs = document.getElementsByTagName('div');
    for(var i=0; i<divs.length; i++){
        var div = divs[i];
        if(div.className === 'tabs'){
            var tabs = [];
            var panes = [];
            for(var node=div.firstChild; node; node=node.nextSibling){
                if(/^tab/.test(node.className)){
                   tabs.push(node);
                }else if(/^pane/.test(node.className)){
                   panes.push(node);
                }
            }
            for(var j=0; j<tabs.length; j++){
                tabs[j].onclick = mk_tab_onclick(j, tabs, panes);
            }
        }
    }
};

init_tabs();

