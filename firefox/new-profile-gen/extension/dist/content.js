"use strict";
window.addEventListener('keydown', function (e) {
    if (handleKeyDown(e)) {
        e.preventDefault();
        e.stopImmediatePropagation();
    }
}, true);
var normalHandlers = {
    'i': function () { return mode = 1 /* Mode.INSERT */; },
    'f': startFind,
    'j': function () { return window.scrollTo(window.scrollX, window.scrollY + 24); },
    'k': function () { return window.scrollTo(window.scrollX, window.scrollY - 24); },
    'g': function () { return window.scrollTo(window.scrollX, 0); },
    'G': function () { return window.scrollTo(window.scrollX, document.body.scrollHeight); },
    'H': function () { return history.back(); },
    'L': function () { return history.forward(); },
    '^d': function () { return window.scrollTo(window.scrollX, window.scrollY + window.innerHeight / 2); },
    '^u': function () { return window.scrollTo(window.scrollX, window.scrollY - window.innerHeight / 2); }
};
var mode = 0 /* Mode.NORMAL */;
function handleKeyDown(e) {
    var target = e.target;
    if (mode === 1 /* Mode.INSERT */ || (target && (target.getAttribute('contenteditable') || ['input', 'textarea', 'select'].indexOf(target.tagName.toLowerCase()) > -1))) {
        if (e.key === 'Escape') {
            mode = 0 /* Mode.NORMAL */;
            target === null || target === void 0 ? void 0 : target.blur();
            return true;
        }
        return false;
    }
    if (mode === 2 /* Mode.FIND */) {
        handleFind(e.key);
        return true;
    }
    var key = e.ctrlKey ? "^".concat(e.key) : e.key;
    if (normalHandlers[key]) {
        normalHandlers[key]();
        return true;
    }
    return false;
}
function getFindElements() {
    var matches = [];
    document.querySelectorAll('a,button,input,textarea').forEach(function (targetEl) {
        var rect = targetEl.getBoundingClientRect();
        if (rect.top < -20 || rect.bottom > window.innerHeight)
            return;
        matches.push([{
                top: rect.top + window.scrollY,
                left: rect.left
            }, targetEl]);
    });
    return matches;
}
function mkEl(type, className) {
    var el = document.createElement(type);
    el.className = "--ext-alexdavid--".concat(className);
    return el;
}
var findState = null;
function startFind() {
    mode = 2 /* Mode.FIND */;
    var matches = getFindElements();
    var findResults = matches.map(function (_a, i) {
        var rect = _a[0], targetEl = _a[1];
        var hintEl = mkEl('div', 'hint');
        hintEl.style.top = "".concat(rect.top, "px");
        hintEl.style.left = "".concat(rect.left, "px");
        var hint = getHintText(i, matches.length);
        var matchedHintEl = mkEl('span', 'matched');
        hintEl.appendChild(matchedHintEl);
        var unmatchedHintEl = mkEl('span', 'unmatched');
        hintEl.appendChild(unmatchedHintEl);
        unmatchedHintEl.textContent = hint;
        document.body.appendChild(hintEl);
        return {
            targetEl: targetEl,
            hintEl: hintEl,
            matchedHintEl: matchedHintEl,
            unmatchedHintEl: unmatchedHintEl,
            hint: hint
        };
    });
    findState = { results: findResults, current: '' };
}
function handleFind(key) {
    if (!findState)
        throw Error('No find state');
    switch (key) {
        case 'Escape':
            clearFind();
            break;
        case 'Backspace':
            findState.current = findState.current.slice(0, -1);
            break;
        default:
            findState.current += key;
    }
    var hasResult = false;
    for (var _i = 0, _a = findState.results; _i < _a.length; _i++) {
        var fr = _a[_i];
        if (fr.hint === findState.current) {
            clearFind();
            fr.targetEl.click();
            fr.targetEl.focus();
            return;
        }
        else if (fr.hint.startsWith(findState.current)) {
            fr.hintEl.style.display = 'block';
            hasResult = true;
        }
        else {
            fr.hintEl.style.display = 'none';
        }
        fr.matchedHintEl.textContent = findState.current;
        fr.unmatchedHintEl.textContent = fr.hint.slice(findState.current.length);
    }
    if (!hasResult)
        clearFind();
}
var hintChars = "abcdefghijklmnopqrstuvwxyz.,/';";
function getHintText(i, total) {
    if (i > total)
        throw Error('overflow');
    if (total <= hintChars.length)
        return hintChars[i];
    return getHintText(i % hintChars.length, hintChars.length) +
        getHintText(Math.floor(i / hintChars.length), Math.floor(total / hintChars.length));
}
function clearFind() {
    if (!findState)
        throw Error('No find state');
    mode = 0 /* Mode.NORMAL */;
    findState.results.forEach(function (fr) {
        fr.hintEl.remove();
    });
}
