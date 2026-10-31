#!/usr/bin/env /home/gmiyazaki/.bun/bin/bun
const readline = require('readline');

const is = (query, obj) => {
  return Array.isArray(obj) ? obj.includes(query) : obj === query;
}

const rl = readline.createInterface({ input: process.stdin });

rl.on('line', line => {
  try {
    const obj = JSON.parse(line);
    if (is('dnd-notification', obj.class) || is('dnd-none', obj.class)) {
      if (obj.text == "0") {
        obj.text = '󰪑';
      } else {
        obj.text = '';
      }
      obj.class = 'disabled';
    } else if (obj.text == "0") {
      obj.text = '';
      obj.class = 'enabled';
    } else {
      obj.text = '󰅸' 
      obj.class = 'active';
    }

    console.log(JSON.stringify(obj));
  } catch {
    console.log(line);
  }
});
