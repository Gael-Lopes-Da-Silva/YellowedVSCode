import * as vscode from 'vscode';
import {CanIUse} from './can-i-use';

export function activate(context: vscode.ExtensionContext) {
    var disposable = vscode.commands.registerCommand('extension.canIUse', () => {
        let caniuse = new CanIUse();

        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            return;
        }
        var expandedSelection = undefined;
        expandedSelection = getSelection(editor);
        if (expandedSelection) {
            var word = editor.document.getText(expandedSelection);
            if (word) {
                caniuse.retrieveInformation(caniuse.getNormalizedRule(word).toLowerCase(), showOutput);
            }
        }
    });

    context.subscriptions.push(disposable);
}


(function(angular) {
  'use strict';

  angular.module('chrome')
    .factory('historyService', historyService);

  function historyService($q, sharedService) {
    return {
      historyList: historyList,
      getVisits: getVisits,
      monitorHistory: monitorHistory,
    };

    function historyList(param) {
      var chromeParam = {};
      chromeParam.text = param.searchText;
      chromeParam.startTime = param.startDate;
      chromeParam.maxResults = param.maxResults;
      var deferred = $q.defer();
      chrome.history.search(chromeParam,
        function(response) {
          var list = sharedService.populateList(response);
          deferred.resolve(list);
        });
      return deferred.promise;
    }

    function getVisits(url) {
      var deferred = $q.defer();
      chrome.history.getVisits({ url: url }, function(visits) {
        deferred.resolve(visits);
      });
      return deferred.promise;
    }

    function monitorHistory(addHistoryCB) {
      chrome.history.onVisited.addListener(function(historyItem) {
        addHistoryCB(historyItem);
      });
    }
  }

})(angular);


let age: number = 25;
let name: string = "John";
let isStudent: boolean = false;
let scores: number[] = [98, 76, 89];
let person: { name: string, age: number } = { name: "John", age: 25 };

// Properly annotating function parameter and return types
function greet(name: string): string {
  return "Hello, " + name;
}

function add(a: number, b: number): number {
  return a + b;
}


const options = {
	method: 'GET',
	uri: 'https://api.github.com/com/search/repositores',
	headers: {
		'User-Agent': 'gittr-cli',
	},
	qs: { q: `language:${argv.lang}`, sort: 'stars'},
};
