import { Marp } from '@marp-team/marp-core'
import { createHighlighterCoreSync } from 'shiki/core'
import { createJavaScriptRegexEngine } from 'shiki/engine/javascript'
import lean from 'shiki/langs/lean.mjs'
import githubLight from 'shiki/themes/github-light.mjs'

// Patch the Lean grammar: remove source.lean4.markdown from comments
// (not bundled in Shiki, causes comment scoping to break)
const leanGrammar = structuredClone(lean)
const g = leanGrammar[0] || leanGrammar
for (const key of ['dashComment', 'docComment', 'modDocComment']) {
  if (g.repository?.[key]) {
    delete g.repository[key].patterns
  }
}

// Custom theme based on github-light with green comments
const theme = structuredClone(githubLight)
theme.name = 'custom-lean'
// Override comment color to green
theme.tokenColors = theme.tokenColors || []
theme.tokenColors.unshift({
  scope: ['comment', 'comment.line', 'comment.block', 'comment.line.double-dash.lean4'],
  settings: { foreground: '#1a7f37' }
})

const highlighter = createHighlighterCoreSync({
  themes: [theme],
  langs: [leanGrammar],
  engine: createJavaScriptRegexEngine(),
})

export default class MarpWithShiki extends Marp {
  highlighter(code, lang) {
    if (lang === 'lean' || lang === 'lean4') {
      const html = highlighter.codeToHtml(code, {
        lang: 'lean',
        theme: 'custom-lean',
      })
      // Marp expects just the inner HTML (no wrapping pre/code tags)
      return html
        .replace(/^<pre[^>]*><code[^>]*>/, '')
        .replace(/<\/code><\/pre>$/, '')
    }
    // Fall back to default highlighter for other languages
    return super.highlighter(code, lang)
  }
}
