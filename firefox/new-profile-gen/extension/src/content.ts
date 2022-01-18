window.addEventListener('keydown', e => {
  if (handleKeyDown(e)) {
    e.preventDefault();
    e.stopImmediatePropagation();
  }
}, true);

const enum Mode {
  NORMAL,
  INSERT,
  FIND,
}

const normalHandlers: Record<string, () => void> = {
  'i': () => mode = Mode.INSERT,
  'f': startFind,
  'j': () => window.scrollTo(window.scrollX, window.scrollY + 24),
  'k': () => window.scrollTo(window.scrollX, window.scrollY - 24),
  'g': () => window.scrollTo(window.scrollX, 0),
  'G': () => window.scrollTo(window.scrollX, document.body.scrollHeight),
  'H': () => history.back(),
  'L': () => history.forward(),
  '^d': () => window.scrollTo(window.scrollX, window.scrollY + window.innerHeight / 2),
  '^u': () => window.scrollTo(window.scrollX, window.scrollY - window.innerHeight / 2),
};

let mode = Mode.NORMAL;
function handleKeyDown(e: KeyboardEvent) {
  const target = e.target as HTMLElement | null;
  if (mode === Mode.INSERT || (target && (target.getAttribute('contenteditable') || ['input', 'textarea', 'select'].indexOf(target.tagName.toLowerCase()) > -1))) {
    if (e.key === 'Escape') {
      mode = Mode.NORMAL;
      target?.blur();
      return true;
    }
    return false;
  }
  if (mode === Mode.FIND) {
    handleFind(e.key);
    return true;
  }
  const key = e.ctrlKey ? `^${e.key}` : e.key;
  if (normalHandlers[key]) {
    normalHandlers[key]();
    return true;
  }
  return false;
}

type FindableTargetElement = HTMLAnchorElement | HTMLButtonElement | HTMLInputElement | HTMLTextAreaElement;

type FindResult = {
  targetEl: FindableTargetElement,
  hintEl: HTMLDivElement,
  matchedHintEl: HTMLSpanElement,
  unmatchedHintEl: HTMLSpanElement,
  hint: string,
}

function getFindElements() {
  const matches: Array<[{ top: number, left: number }, FindableTargetElement]> = [];
  (document.querySelectorAll('a,button,input,textarea') as NodeListOf<FindableTargetElement>).forEach(targetEl => {
    const rect = targetEl.getBoundingClientRect();
    if (rect.top < -20 || rect.bottom > window.innerHeight) return;
    matches.push([{
      top: rect.top + window.scrollY,
      left: rect.left,
    }, targetEl]);
  });
  return matches;
}

type FindState = {
  results: Array<FindResult>,
  current: string,
};

function mkEl<K extends keyof HTMLElementTagNameMap>(type: K, className: string): HTMLElementTagNameMap[K] {
  const el = document.createElement(type);
  el.className = `--ext-alexdavid--${className}`;
  return el;
}

let findState: FindState | null = null;
function startFind() {
  mode = Mode.FIND;
  const matches = getFindElements();
  const findResults = matches.map(([rect, targetEl], i): FindResult => {
    const hintEl = mkEl('div', 'hint');
    hintEl.style.top = `${rect.top}px`;
    hintEl.style.left = `${rect.left}px`;
    const hint = getHintText(i, matches.length);
    const matchedHintEl = mkEl('span', 'matched');
    hintEl.appendChild(matchedHintEl);
    const unmatchedHintEl = mkEl('span', 'unmatched');
    hintEl.appendChild(unmatchedHintEl);
    unmatchedHintEl.textContent = hint;
    document.body.appendChild(hintEl);
    return {
      targetEl,
      hintEl,
      matchedHintEl,
      unmatchedHintEl,
      hint,
    };
  });
  findState = { results: findResults, current: '' };
}

function handleFind(key: string) {
  if (!findState) throw Error('No find state');
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
  let hasResult = false;
  for (const fr of findState.results) {
    if (fr.hint === findState.current) {
      clearFind();
      fr.targetEl.click();
      fr.targetEl.focus();
      return;
    } else if (fr.hint.startsWith(findState.current)) {
      fr.hintEl.style.display = 'block';
      hasResult = true;
    } else {
      fr.hintEl.style.display = 'none';
    }
    fr.matchedHintEl.textContent = findState.current;
    fr.unmatchedHintEl.textContent = fr.hint.slice(findState.current.length);
  }
  if (!hasResult) clearFind();
}

const hintChars = "abcdefghijklmnopqrstuvwxyz.,/';";
function getHintText(i: number, total: number): string {
  if (i > total) throw Error('overflow');
  if (total <= hintChars.length) return hintChars[i];
  return getHintText(i % hintChars.length, hintChars.length) +
    getHintText(Math.floor(i / hintChars.length), Math.floor(total / hintChars.length));
}

function clearFind() {
  if (!findState) throw Error('No find state');
  mode = Mode.NORMAL;
  findState.results.forEach(fr => {
    fr.hintEl.remove();
  });
}
