// Supporting functions for the display of post archives

function toggleDisplay(element) {
    if (!element.style) {
        element.style = { display: 'none' };
    }
    else if (element.style.display === 'none') {
        element.style.display = 'block'
    }
    else {
        element.style.display = 'none';
    }
}
function toggleBrothersDisplay(element, tag) {
    var brother;
    var brothers = element.parentElement.children;
    for(var i = 0; i < brothers.length; i++) {
        brother = brothers[i];
        if (brother.tagName === tag) {
            toggleDisplay(brother);
        }
    }
}
