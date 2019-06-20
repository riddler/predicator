const fs = require('fs')
const Liquid = require('liquidjs')
const LiquidEngine = new Liquid()
const YAML = require('yaml')

LiquidEngine.registerFilter('json', v => JSON.stringify(v))

//----------------- Evaluator ---------------------

const evaluatorSpecRoot = '../predicator_spec/evaluator'


const templateSource = `// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { PredicatorEvaluator } = require('../../src/predicator')
{% for test in tests %}

test('it evaluates {{ name }} {{test.name}}', () => {
  const evaluator = new PredicatorEvaluator(
    {{ instructions | json }},
    {% if test.context %}{{ test.context | json }}{% else %}{}{% endif %});
  expect(evaluator.result()).toEqual({{ test.result }});
  expect(evaluator.stack).toEqual([]);
}){% endfor %}`




const evaluatorTemplate = LiquidEngine.parse(templateSource)

const generateEvaluatorSpec = function(inputFilePath) {
  console.log(`Generating test from ${inputFilePath}`)

  const fullInputPath = `${evaluatorSpecRoot}/${inputFilePath}`

  fs.readFile(fullInputPath, 'utf8', (err, yamlContents) => {
    const specData = YAML.parse(yamlContents)

    const outputPath = `test/evaluator/${specData.name}.test.js`

    LiquidEngine.render(evaluatorTemplate, specData).then( outputContents => {
      fs.writeFile(outputPath, outputContents, err => {
        if (err) {
          return console.error(`Could not save file: ${err.message}`)
        }
      })
    })
  })

}

fs.readdir(evaluatorSpecRoot, (err, files) => {
  files.filter(e => e.endsWith("yml")).forEach(file => generateEvaluatorSpec(file))
})





//----------------- Visitors ---------------------

const visitorsSpecRoot = '../predicator_spec/visitors'


const visitorSource = `// This file is auto-generated.
// To make changes - look in scripts/generate-tests.js

const { compile } = require('../../src/predicator')
{% for test in tests %}

test('it compiles {{test.name}}', () => {
  expect(compile('{{ test.source }}')).toEqual({{ test.instructions | json }})
}){% endfor %}`




const visitorTemplate = LiquidEngine.parse(visitorSource)

const generateVisitorSpec = function(inputFilePath) {
  console.log(`Generating test from ${inputFilePath}`)

  const fullInputPath = `${visitorsSpecRoot}/${inputFilePath}`

  fs.readFile(fullInputPath, 'utf8', (err, yamlContents) => {
    const specData = YAML.parse(yamlContents)

    const outputPath = `test/visitors/${specData.name}.test.js`

    LiquidEngine.render(visitorTemplate, specData).then( outputContents => {
      fs.writeFile(outputPath, outputContents, err => {
        if (err) {
          return console.error(`Could not save file: ${err.message}`)
        }
      })
    })
  })

}

fs.readdir(visitorsSpecRoot, (err, files) => {
  files.forEach(file => generateVisitorSpec(file))
})
