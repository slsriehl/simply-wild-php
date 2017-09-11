/*!
 * Simply Wild Gardens - 1.5 - simplywildgardens.com

 * MIT License
 * Copyright 2014-2017 Sarah Schieffer Riehl with Suzi Sands
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
var addEvent, checkIfEl, formToJson, goToMenuItems, isReady, isValidElement, isValidValue, makeEvent, removeEvent, renderMessage, request, resetJump, submitForm, toggleAddClick, toggleMenu;

request = function(method, path, data) {
  return new Promise(function(resolve, reject) {
    var req;
    req = new XMLHttpRequest();
    req.open(method, path);
    req.onload = function() {
      if (req.status === 200) {
        return resolve(req.responseText);
      } else {
        return reject(Error(req.statusText));
      }
    };
    req.onerror = function() {
      return reject(Error('unknown error'));
    };
    return req.send(JSON.stringify(data));
  });
};

toggleAddClick = function(clickEl, menu, overlay) {
  console.log('toggle add click');
  return toggleMenu(menu, overlay, clickEl);
};

toggleMenu = function(menu, overlay, toggle) {
  console.log('toggle menu');
  if (window.getComputedStyle(menu, null).getPropertyValue('visibility') === 'hidden') {
    console.log('toggle menu');
    menu.style.visibility = 'unset';
    overlay.style.visibility = 'unset';
    toggle.style.visibility = 'hidden';
    menu.style.zIndex = '150';
    return overlay.style.zIndex = '105';
  } else {
    console.log('toggle no menu');
    menu.style.visibility = 'hidden';
    overlay.style.visibility = 'hidden';
    toggle.style.visibility = 'unset';
    menu.style.zIndex = '-1';
    return overlay.style.zIndex = '-1';
  }
};

resetJump = function() {
  console.log('reset jump');
  return history.pushState("", document.title, window.location.pathname + window.location.search);
};

goToMenuItems = function(parentEl, overlay, toggle, jumpName) {
  console.log('go to menu items');
  resetJump();
  toggleMenu(parentEl, overlay, toggle);
  return window.location.hash = "\u0023" + jumpName;
};

isValidElement = function(element) {
  return element.name && element.value;
};

isValidValue = function(element) {
  return !['checkbox', 'radio'].includes(element.type) || element.checked;
};

formToJson = function(elements) {
  return [].reduce.call(elements, function(data, element) {
    if (isValidElement(element) && isValidValue(element)) {
      data[element.name] = element.value;
    }
    return data;
  }, {});
};

isReady = function(el, handler) {
  if (el.addEventListener) {
    console.log('is ready add EL');
    return el.addEventListener('DOMContentLoaded', handler);
  } else {
    console.log('is ready not EL');
    el.readyState === 'complete';
    return void 0;
  }
};

addEvent = function(el, type, handler) {
  console.log('add event');
  if (el.attachEvent) {
    console.log('attach event');
    return el.attachEvent("on" + type, handler);
  } else {
    console.log('add event listener');
    return el.addEventListener(type, handler);
  }
};

removeEvent = function(el, type, handler) {
  console.log('remove event');
  if (el.detachEvent) {
    console.log('detach event');
    return el.detachEvent("on" + type, handler);
  } else {
    console.log('remove event listener');
    return el.removeEventListener(type, handler);
  }
};

makeEvent = function(el, type, removeHandler, addHandler) {
  console.log('make event');
  removeEvent(el, type, removeHandler);
  return addEvent(el, type, addHandler);
};

checkIfEl = function(el, type, removeHandler, addHandler) {
  console.log('check if el');
  if (el) {
    console.log('el exists');
    return makeEvent(el, type, removeHandler, addHandler);
  } else {
    console.log('no el');
  }
};

isReady(document, function() {
  var emailForm, footerCopyright, footerDate, hideOnSubmitSpan, inputs, menu, menuItems, overlay, replaceOnSubmitSpan, theYear, toggle, toggleMenuAnon;
  console.log('is ready');
  emailForm = document.getElementById('emailSuzy');
  hideOnSubmitSpan = document.getElementById('hideOnSubmit');
  replaceOnSubmitSpan = document.getElementById('replaceOnSubmit');
  checkIfEl(emailForm, 'submit', null, function() {
    return submitForm(event, emailForm, hideOnSubmitSpan, replaceOnSubmitSpan);
  });
  toggle = document.getElementById('header__menu__toggle');
  menu = document.getElementById('header__menu__hmm__id');
  overlay = document.getElementById('menuOverlay');
  console.log(toggle);
  console.log(menu);
  toggleMenuAnon = function() {
    return toggleMenu(menu, overlay, toggle);
  };
  checkIfEl(toggle, 'click', null, function() {
    console.log('check if el add EL pre toggle add click');
    return toggleAddClick(toggle, menu, overlay);
  });
  menuItems = [].slice.call(document.getElementsByClassName('hmm__list'));
  console.log(menuItems);
  checkIfEl(overlay, 'click', toggleMenuAnon, toggleMenuAnon);
  console.log('before for each');
  menuItems.forEach(function(element, index, array) {
    var dataAttr;
    console.log(element);
    dataAttr = element.dataset.link;
    console.log(dataAttr);
    return makeEvent(element, 'click', resetJump, function() {
      return goToMenuItems(menu, overlay, toggle, dataAttr);
    });
  });
  console.log('after for each');
  inputs = [].slice.call(document.getElementsByClassName('contact__input'));
  console.log(inputs);
  inputs.forEach(function(element, index, array) {
    console.log(element);
    return element.addEventListener('blur', function() {
      if (element.value) {
        return element.classList.add('contact__input--filled');
      } else if (element.classList.contains('contact__input--filled')) {
        return element.classList.remove('contact__input--filled');
      }
    });
  });
  footerDate = function() {
    var thisDate;
    thisDate = new Date().getFullYear();
    console.log(thisDate);
    return "2014-" + thisDate + "&nbsp;";
  };
  footerCopyright = document.getElementById('footerCopy');
  theYear = document.createElement('span');
  theYear.innerHTML = footerDate();
  return footerCopyright.appendChild(theYear);
});

submitForm = function(event, el, hideMe, replaceMe) {
  var data;
  event.preventDefault();
  data = formToJson(event.target.elements);
  return request('POST', 'php/send-mail.php', data).then(function(result) {
    var message;
    console.log(result);
    if (result === 'success sending') {
      message = 'Your message was successfully sent. ';
    } else if (result === 'captcha fail') {
      message = "Please check the captcha and try again. ";
    } else {
      message = "Sorry, we couldn't send your message.  Try again later. ";
    }
    return renderMessage(el, hideMe, replaceMe, message);
  })["catch"](function(error) {
    var message;
    message = "Sorry, we couldn't send your message.  Try again later. ";
    return renderMessage(el, hideMe, replaceMe, message);
  });
};

renderMessage = function(el, hideMe, replaceMe, message) {
  replaceMe.innerHTML = message;
  hideMe.style.display = 'none';
  if (message === 'Your message was successfully sent. ') {
    console.log('success message');
    el.style.display = 'none';
  } else {
    console.log('failed message');
    replaceMe.style.color = '#C70039';
  }
  resetJump();
  return window.location.hash = "\u0023contact";
};
