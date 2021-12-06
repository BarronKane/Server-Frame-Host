import svelte from 'rollup-plugin-svelte';
import commonjs from '@rollup/plugin-commonjs';
import resolve from '@rollup/plugin-node-resolve';
import { terser } from 'rollup-plugin-terser';
import css from 'rollup-plugin-css-only';
import copy from 'rollup-plugin-copy';
import { scss } from 'svelte-preprocess';

const production = !process.env.ROLLUP_WATCH;

export default {
    input: 'ui/main.js',
    output: {
        sourcemap: true,
        format: 'cjs',
        name: 'app',
        exports: 'auto',
        file: 'resources/app/bundle.js'
    },
    plugins: [
        svelte({
            compilerOptions: {
                dev: !production
            },
            preprocess: [
                scss({  })
            ]
        }),
        
        css({ output: 'bundle.css' }),
        resolve({
            browser: true,
            dedupe: ['svelte']
        }),
        commonjs(),
        production && terser(),
        copy({
            targets: [
                { src: 'ui/index.html', dest: 'resources/app' },
            ]
        }),
    ]
}
