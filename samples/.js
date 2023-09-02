/**
 * JavaScript: Shades of purple can be genius
 *
 * @param String hello Hello.
 * @since 1.0.0
 */

// String.
const world = '🗺️';

const sop = '🦄 Shades of Purple is an awesome syntax highlighting theme.';
console.log('sop', sop);

// Class.
class vsc extends React.Component {}
console.log(vsc);

// Const.
const ahmad = function nameAhmad() {
	return 'Ahmad';
};
ahmad();

// Let.
let awais = () => 'Awais';
console.log(awais);

/**
 * Maedah's Function.
 *
 * @param String name
 */
function maedah(name) {
	return name;
}

maedah('Maedah Batool');

// Regex.
const coursePlatformURL = new RegExp('/' + window.location.host + '/');
console.log('coursePlatformURL', coursePlatformURL);

import { btnBarSvgSpeed } from './constants';

/**
 *  Angle increment.
 *
 * — 360/(total speed values).
 * — 360/6 = 60.
 */
export const speedAngles = {
	'1': '0',
	'1.25': '60',
	'1.5': '120',
	'1.75': '180',
	'2': '240',
	'0.75': '300'
};

/**
 * Speed SVG CSS.
 *
 * @param Number one Angle to rotate the SVG.
 * @param Number two Angle to rotate the SVG.
 * @param Number three Angle to rotate the SVG.
 */
export const speedCSS = (one, two, three) => {
	btnBarSvgSpeed.css({
		transform: `rotate(${one}deg)`,
		transform: `rotate(${two}deg)`,
		transform: `rotate(${three}deg)`
	});
};

// Conditionals.
if (ahmad) {
	console.log('Ahmad loves open source');
} else if (awais) {
	console.log('Awais is making 🦄 Shades of Purple');
} else {
	console.log('Call it SOP for brevity');
}

/**
 * Demo of Shades of Purple VSCode theme.
 *
 * I'm 💜'ing it.
 */
import React from 'react';
import { render } from 'react-dom';
import styled from 'styled-components';

const Wrap = styled.div`
	display: table;
	width: 100%;
`;

const Message = styled.p`
	font-size: 1.8rem;
	line-height: 1.45;
`;

/**
 * VSCode Component.
 *
 * @class VSCode
 * @extends {React.Component}
 */
class VSCode extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			value: null
		};
	}

	// Render it baby.
	render() {
		return (
			<Wrap>
				<button onClick={() => alert('Stop clicking me!')}>{this.props.value}</button>
				<Message>Testing the React.js Syntax in VSCode Shades of Purple 💜 theme.</Message>
			</Wrap>
		);
	}
}

// Show it to all.
render(VSCode, document.getElementById('root'));

// program to sort array by property name

function compareName(a, b) {

    // converting to uppercase to have case-insensitive comparison
    const name1 = a.name.toUpperCase();
    const name2 = b.name.toUpperCase();

    let comparison = 0;

    if (name1 > name2) {
        comparison = 1;
    } else if (name1 < name2) {
        comparison = -1;
    }
    return comparison;
}

const students = [{name: 'Sara', age:24},{name: 'John', age:24}, {name: 'Jack', age:25}];

console.log(students.sort(compareName));
