const { readFile } = require('fs').promises;
const { join } = require('path');
const { Type, DEFAULT_SCHEMA, load } = require('js-yaml');

/**
 * @typedef {Object} TokenColor
 * @prop {string} [name]
 * @prop {string[]} scope
 * @prop {Record<'foreground'|'background'|'fontStyle',string|undefined>} settings
 */

/**
 * @typedef {Object} Theme
 * @prop {Record<'base'|'ansi'|'brightOther'|'other', string[]>} dracula
 * @prop {Record<string, string|null|undefined>} colors
 * @prop {TokenColor[]} tokenColors
 */

/**
 * @typedef {(yamlObj: Theme) => Theme} ThemeTransform
 */

const withAlphaType = new Type('!alpha', {
    kind: 'sequence',
    construct: ([hexRGB, alpha]) => hexRGB + alpha,
    represent: ([hexRGB, alpha]) => hexRGB + alpha,
});

const schema = DEFAULT_SCHEMA.extend([withAlphaType]);

module.exports = async () => {
    const yamlFile = await readFile(
        join(__dirname, '..', 'theme', 'yellowed.yml'),
        'utf-8'
    );

    /** @type {Theme} */
    const base = load(yamlFile, { schema });
    for (const key of Object.keys(base.colors)) {
        if (!base.colors[key]) {
            delete base.colors[key];
        }
    }

    return base;
};
