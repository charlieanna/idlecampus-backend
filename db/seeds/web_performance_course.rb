# Web Performance Optimization Course
puts "Creating Web Performance Optimization Course..."

perf_course = Course.find_or_create_by!(slug: 'web-performance-optimization') do |course|
  course.title = 'Web Performance Optimization'
  course.description = 'Master web performance optimization from Core Web Vitals to advanced caching strategies and PWA'
  course.difficulty_level = 'intermediate'
  course.published = true
  course.sequence_order = 33
  course.estimated_hours = 26
  course.learning_objectives = JSON.generate([
    "Measure and optimize Core Web Vitals (LCP, FID, CLS)",
    "Implement resource loading and image optimization",
    "Optimize JavaScript and CSS performance",
    "Configure caching strategies and CDN",
    "Implement Service Workers and PWA",
    "Monitor and enforce performance budgets"
  ])
  course.prerequisites = JSON.generate(["HTML/CSS fundamentals", "JavaScript basics", "Web development experience"])
end

puts "Created course: #{perf_course.title}"

# ==========================================
# MODULE 1: Performance Fundamentals
# ==========================================

module1 = CourseModule.find_or_create_by!(slug: 'performance-fundamentals', course: perf_course) do |mod|
  mod.title = 'Performance Fundamentals'
  mod.description = 'Core Web Vitals, critical rendering path, and resource optimization'
  mod.sequence_order = 1
  mod.estimated_minutes = 100
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Understand and measure Core Web Vitals",
    "Optimize critical rendering path",
    "Implement image and font optimization",
    "Use Lighthouse for performance auditing"
  ])
end

lesson1_1 = CourseLesson.find_or_create_by!(title: "Web Performance Metrics and Optimization") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Web Performance Metrics and Optimization

    Performance directly impacts user experience, conversion rates, and SEO rankings. Understanding and optimizing Core Web Vitals is essential for modern web development.

    ## Core Web Vitals

    Google's Core Web Vitals measure real-world user experience across three dimensions:

    ### 1. Largest Contentful Paint (LCP)

    **Measures loading performance** - when the largest content element becomes visible.

    **Target: < 2.5 seconds**

    ```javascript
    // Measuring LCP with PerformanceObserver
    const observer = new PerformanceObserver((list) => {
      const entries = list.getEntries();
      const lastEntry = entries[entries.length - 1];

      console.log('LCP:', lastEntry.renderTime || lastEntry.loadTime);
      console.log('LCP Element:', lastEntry.element);
    });

    observer.observe({ type: 'largest-contentful-paint', buffered: true });
    ```

    **Common LCP elements:**
    - Hero images
    - Video thumbnails
    - Background images via CSS
    - Text blocks

    **How to optimize LCP:**

    ```html
    <!-- 1. Preload critical resources -->
    <link rel="preload" as="image" href="/hero.jpg" fetchpriority="high">

    <!-- 2. Use appropriate image formats -->
    <picture>
      <source srcset="/hero.webp" type="image/webp">
      <source srcset="/hero.avif" type="image/avif">
      <img src="/hero.jpg" alt="Hero" width="1200" height="600">
    </picture>

    <!-- 3. Optimize server response time -->
    <!-- Use CDN, HTTP/2, server-side caching -->
    ```

    ### 2. First Input Delay (FID) / Interaction to Next Paint (INP)

    **Measures interactivity** - time from user interaction to browser response.

    **Target FID: < 100ms | Target INP: < 200ms**

    ```javascript
    // Measuring FID
    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        const FID = entry.processingStart - entry.startTime;
        console.log('FID:', FID);

        // Send to analytics
        gtag('event', 'web_vitals', {
          event_category: 'Web Vitals',
          event_label: 'FID',
          value: Math.round(FID)
        });
      }
    });

    observer.observe({ type: 'first-input', buffered: true });
    ```

    **How to optimize FID/INP:**

    ```javascript
    // 1. Break up long tasks
    // Bad: Blocking task
    function processLargeArray(items) {
      items.forEach(item => {
        // Heavy processing
        processItem(item);
      });
    }

    // Good: Yield to main thread
    async function processLargeArray(items) {
      for (let i = 0; i < items.length; i++) {
        processItem(items[i]);

        // Yield to browser every 50ms
        if (i % 100 === 0) {
          await new Promise(resolve => setTimeout(resolve, 0));
        }
      }
    }

    // 2. Use web workers for heavy computation
    // main.js
    const worker = new Worker('worker.js');
    worker.postMessage({ data: largeDataset });
    worker.onmessage = (e) => {
      console.log('Result:', e.data);
    };

    // worker.js
    self.onmessage = (e) => {
      const result = heavyComputation(e.data);
      self.postMessage(result);
    };

    // 3. Defer non-critical JavaScript
    // Use async/defer attributes
    ```

    ### 3. Cumulative Layout Shift (CLS)

    **Measures visual stability** - unexpected layout shifts during page load.

    **Target: < 0.1**

    ```javascript
    // Measuring CLS
    let clsScore = 0;

    const observer = new PerformanceObserver((list) => {
      for (const entry of list.getEntries()) {
        if (!entry.hadRecentInput) {
          clsScore += entry.value;
          console.log('CLS:', clsScore);
          console.log('Shifted element:', entry.sources);
        }
      }
    });

    observer.observe({ type: 'layout-shift', buffered: true });
    ```

    **How to optimize CLS:**

    ```html
    <!-- 1. Always set image dimensions -->
    <img src="/image.jpg" width="800" height="600" alt="Photo">

    <!-- 2. Reserve space for ads/embeds -->
    <div class="ad-container" style="min-height: 250px;">
      <!-- Ad loads here -->
    </div>

    <!-- 3. Use aspect ratio boxes -->
    <style>
      .video-container {
        aspect-ratio: 16 / 9;
        width: 100%;
      }
    </style>
    <div class="video-container">
      <iframe src="video.mp4"></iframe>
    </div>

    <!-- 4. Preload fonts to avoid FOIT/FOUT -->
    <link rel="preload" href="/fonts/main.woff2" as="font" type="font/woff2" crossorigin>
    ```

    ## Lighthouse Scoring

    Lighthouse audits performance across multiple categories:

    ```javascript
    // Run Lighthouse programmatically
    const lighthouse = require('lighthouse');
    const chromeLauncher = require('chrome-launcher');

    async function runLighthouse(url) {
      const chrome = await chromeLauncher.launch({ chromeFlags: ['--headless'] });

      const options = {
        logLevel: 'info',
        output: 'json',
        port: chrome.port
      };

      const runnerResult = await lighthouse(url, options);

      // Performance score
      console.log('Performance:', runnerResult.lhr.categories.performance.score * 100);

      // Core Web Vitals
      console.log('LCP:', runnerResult.lhr.audits['largest-contentful-paint'].numericValue);
      console.log('TBT:', runnerResult.lhr.audits['total-blocking-time'].numericValue);
      console.log('CLS:', runnerResult.lhr.audits['cumulative-layout-shift'].numericValue);

      await chrome.kill();
    }
    ```

    **Lighthouse scoring weights:**
    - First Contentful Paint: 10%
    - Speed Index: 10%
    - Largest Contentful Paint: 25%
    - Total Blocking Time: 30%
    - Cumulative Layout Shift: 25%

    ## Critical Rendering Path

    Understanding how browsers render pages is key to optimization:

    ```
    HTML → DOM Tree
    CSS  → CSSOM Tree
              ↓
        Render Tree
              ↓
          Layout
              ↓
           Paint
              ↓
         Composite
    ```

    ### Optimizing Critical Rendering Path

    ```html
    <!DOCTYPE html>
    <html>
    <head>
      <!-- 1. Inline critical CSS -->
      <style>
        /* Above-the-fold styles */
        .hero { background: #fff; padding: 20px; }
        .nav { display: flex; }
      </style>

      <!-- 2. Preload critical resources -->
      <link rel="preload" as="style" href="/styles.css">
      <link rel="preload" as="script" href="/main.js">

      <!-- 3. Load non-critical CSS asynchronously -->
      <link rel="preload" as="style" href="/non-critical.css"
            onload="this.onload=null;this.rel='stylesheet'">
      <noscript><link rel="stylesheet" href="/non-critical.css"></noscript>

      <!-- 4. Defer JavaScript -->
      <script src="/main.js" defer></script>
    </head>
    <body>
      <!-- Content -->
    </body>
    </html>
    ```

    ## Resource Loading Optimization

    ### Resource Hints

    ```html
    <!-- DNS Prefetch: Resolve DNS early -->
    <link rel="dns-prefetch" href="//api.example.com">

    <!-- Preconnect: Establish connection early -->
    <link rel="preconnect" href="https://cdn.example.com" crossorigin>

    <!-- Prefetch: Load for next navigation -->
    <link rel="prefetch" href="/next-page.html">

    <!-- Preload: Load critical resource immediately -->
    <link rel="preload" href="/critical.js" as="script">

    <!-- Prerender: Render entire page in background (use sparingly) -->
    <link rel="prerender" href="/next-page.html">
    ```

    ### Priority Hints

    ```html
    <!-- High priority for hero image -->
    <img src="/hero.jpg" fetchpriority="high" alt="Hero">

    <!-- Low priority for below-fold images -->
    <img src="/footer-logo.jpg" fetchpriority="low" alt="Logo">

    <!-- High priority for critical script -->
    <script src="/critical.js" fetchpriority="high"></script>
    ```

    ## Image Optimization

    ### Modern Image Formats

    ```html
    <!-- Use picture element for format fallbacks -->
    <picture>
      <!-- AVIF: Best compression (60% smaller than JPEG) -->
      <source srcset="/image.avif" type="image/avif">

      <!-- WebP: Good compression (30% smaller than JPEG) -->
      <source srcset="/image.webp" type="image/webp">

      <!-- JPEG: Fallback for older browsers -->
      <img src="/image.jpg" alt="Description" width="800" height="600">
    </picture>
    ```

    ### Responsive Images

    ```html
    <!-- Serve different sizes based on viewport -->
    <img
      src="/image-800.jpg"
      srcset="
        /image-400.jpg 400w,
        /image-800.jpg 800w,
        /image-1200.jpg 1200w,
        /image-1600.jpg 1600w
      "
      sizes="
        (max-width: 400px) 400px,
        (max-width: 800px) 800px,
        (max-width: 1200px) 1200px,
        1600px
      "
      alt="Responsive image"
      width="1600"
      height="900"
    >
    ```

    ### Lazy Loading

    ```html
    <!-- Native lazy loading -->
    <img src="/image.jpg" loading="lazy" alt="Lazy image">

    <!-- JavaScript implementation with Intersection Observer -->
    <script>
      const images = document.querySelectorAll('img[data-src]');

      const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const img = entry.target;
            img.src = img.dataset.src;
            img.removeAttribute('data-src');
            observer.unobserve(img);
          }
        });
      }, {
        rootMargin: '50px' // Load 50px before entering viewport
      });

      images.forEach(img => imageObserver.observe(img));
    </script>
    ```

    ### Image Compression

    ```javascript
    // Using sharp for server-side optimization
    const sharp = require('sharp');

    async function optimizeImage(inputPath, outputPath) {
      await sharp(inputPath)
        .resize(1200, 900, { fit: 'cover' })
        .webp({ quality: 80 })
        .toFile(outputPath);
    }

    // Generate multiple formats
    async function generateResponsiveImages(input) {
      const sizes = [400, 800, 1200, 1600];

      for (const size of sizes) {
        // WebP
        await sharp(input)
          .resize(size)
          .webp({ quality: 80 })
          .toFile(`image-${size}.webp`);

        // AVIF
        await sharp(input)
          .resize(size)
          .avif({ quality: 75 })
          .toFile(`image-${size}.avif`);

        // JPEG fallback
        await sharp(input)
          .resize(size)
          .jpeg({ quality: 85 })
          .toFile(`image-${size}.jpg`);
      }
    }
    ```

    ## Font Optimization

    ### Font Loading Strategies

    ```html
    <head>
      <!-- 1. Preload critical fonts -->
      <link rel="preload" href="/fonts/main.woff2"
            as="font" type="font/woff2" crossorigin>

      <!-- 2. Use font-display for control -->
      <style>
        @font-face {
          font-family: 'MainFont';
          src: url('/fonts/main.woff2') format('woff2');
          font-display: swap; /* Show fallback immediately */
          font-weight: 400;
          font-style: normal;
        }

        /* Optional: Reduce layout shift */
        @font-face {
          font-family: 'MainFont';
          src: local('Arial'); /* Use system font as fallback */
          size-adjust: 95%; /* Match x-height of web font */
          ascent-override: 90%;
          descent-override: 20%;
        }
      </style>
    </head>
    ```

    ### Font Display Options

    ```css
    @font-face {
      font-family: 'MyFont';
      src: url('/font.woff2') format('woff2');

      /* font-display options */
      font-display: auto;     /* Browser default (usually block) */
      font-display: block;    /* Hide text up to 3s, then swap */
      font-display: swap;     /* Show fallback immediately, swap when loaded */
      font-display: fallback; /* 100ms invisible, 3s swap period, then stick with fallback */
      font-display: optional; /* 100ms block, browser decides to swap or not */
    }
    ```

    ### Subsetting Fonts

    ```javascript
    // Using glyphhanger to subset fonts
    // Install: npm install -g glyphhanger

    // Generate subset for specific characters
    // glyphhanger --subset=font.ttf --whitelist="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

    // In CSS, use unicode-range
    @font-face {
      font-family: 'MyFont';
      src: url('/font-latin.woff2') format('woff2');
      unicode-range: U+0000-00FF; /* Latin characters only */
    }

    @font-face {
      font-family: 'MyFont';
      src: url('/font-extended.woff2') format('woff2');
      unicode-range: U+0100-017F; /* Latin Extended */
    }
    ```

    ### Variable Fonts

    ```css
    /* Use variable fonts to reduce file count */
    @font-face {
      font-family: 'MyVariableFont';
      src: url('/font-variable.woff2') format('woff2-variations');
      font-weight: 100 900; /* Entire weight range in one file */
      font-display: swap;
    }

    .heading {
      font-family: 'MyVariableFont';
      font-weight: 700; /* Interpolated from variable font */
    }

    .body {
      font-family: 'MyVariableFont';
      font-weight: 400;
    }
    ```

    ## Performance Monitoring

    ### Using Performance API

    ```javascript
    // Navigation Timing
    const perfData = performance.getEntriesByType('navigation')[0];
    console.log('DNS lookup:', perfData.domainLookupEnd - perfData.domainLookupStart);
    console.log('TCP connection:', perfData.connectEnd - perfData.connectStart);
    console.log('Request:', perfData.responseStart - perfData.requestStart);
    console.log('Response:', perfData.responseEnd - perfData.responseStart);
    console.log('DOM Processing:', perfData.domComplete - perfData.domLoading);

    // Resource Timing
    const resources = performance.getEntriesByType('resource');
    resources.forEach(resource => {
      console.log(`${resource.name}: ${resource.duration}ms`);
    });

    // Custom marks and measures
    performance.mark('operation-start');
    // ... perform operation
    performance.mark('operation-end');
    performance.measure('operation', 'operation-start', 'operation-end');

    const measure = performance.getEntriesByName('operation')[0];
    console.log('Operation took:', measure.duration, 'ms');
    ```

    ## Best Practices Summary

    1. **Measure First**: Use Lighthouse, WebPageTest, and real user monitoring
    2. **Optimize Images**: Use modern formats (AVIF, WebP), responsive images, lazy loading
    3. **Minimize Critical Resources**: Inline critical CSS, defer non-critical JavaScript
    4. **Use Resource Hints**: Preconnect to important origins, preload critical resources
    5. **Optimize Fonts**: Preload critical fonts, use font-display: swap, subset fonts
    6. **Reduce Layout Shifts**: Set image dimensions, reserve space for dynamic content
    7. **Monitor Continuously**: Track Core Web Vitals in production with RUM

    Performance is not a one-time task but an ongoing process. Set performance budgets and monitor them continuously.
  MARKDOWN
  lesson.key_concepts = ['Core Web Vitals', 'LCP', 'FID', 'CLS', 'Lighthouse', 'critical rendering path', 'image optimization', 'lazy loading', 'font optimization', 'resource hints']
end

ModuleItem.find_or_create_by!(course_module: module1, item: lesson1_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 2: JavaScript & CSS Optimization
# ==========================================

module2 = CourseModule.find_or_create_by!(slug: 'javascript-css-optimization', course: perf_course) do |mod|
  mod.title = 'JavaScript & CSS Optimization'
  mod.description = 'Code splitting, tree shaking, minification, and CSS optimization'
  mod.sequence_order = 2
  mod.estimated_minutes = 120
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement code splitting and lazy loading",
    "Optimize bundle size with tree shaking",
    "Configure minification and compression",
    "Optimize CSS delivery and eliminate unused CSS"
  ])
end

lesson2_1 = CourseLesson.find_or_create_by!(title: "Optimizing JavaScript and CSS") do |lesson|
  lesson.reading_time_minutes = 35
  lesson.content = <<~MARKDOWN
    # Optimizing JavaScript and CSS

    JavaScript and CSS are often the largest blocking resources. Optimizing them is critical for performance.

    ## Code Splitting

    Breaking your JavaScript bundle into smaller chunks that load on-demand.

    ### Route-based Code Splitting

    ```javascript
    // Using React Router with lazy loading
    import { lazy, Suspense } from 'react';
    import { BrowserRouter, Routes, Route } from 'react-router-dom';

    // Lazy load route components
    const Home = lazy(() => import('./pages/Home'));
    const Dashboard = lazy(() => import('./pages/Dashboard'));
    const Profile = lazy(() => import('./pages/Profile'));

    function App() {
      return (
        <BrowserRouter>
          <Suspense fallback={<div>Loading...</div>}>
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/dashboard" element={<Dashboard />} />
              <Route path="/profile" element={<Profile />} />
            </Routes>
          </Suspense>
        </BrowserRouter>
      );
    }
    ```

    ### Component-based Code Splitting

    ```javascript
    // Lazy load heavy components
    import { lazy, Suspense } from 'react';

    const HeavyChart = lazy(() => import('./HeavyChart'));
    const VideoPlayer = lazy(() => import('./VideoPlayer'));

    function Dashboard() {
      const [showChart, setShowChart] = useState(false);

      return (
        <div>
          <h1>Dashboard</h1>

          <button onClick={() => setShowChart(true)}>
            Show Chart
          </button>

          {showChart && (
            <Suspense fallback={<ChartSkeleton />}>
              <HeavyChart data={chartData} />
            </Suspense>
          )}
        </div>
      );
    }
    ```

    ### Webpack Code Splitting Configuration

    ```javascript
    // webpack.config.js
    module.exports = {
      entry: './src/index.js',
      output: {
        filename: '[name].[contenthash].js',
        chunkFilename: '[name].[contenthash].chunk.js',
        path: path.resolve(__dirname, 'dist')
      },
      optimization: {
        splitChunks: {
          chunks: 'all',
          cacheGroups: {
            // Vendor code (node_modules)
            vendor: {
              test: /[\\/]node_modules[\\/]/,
              name: 'vendors',
              priority: 10
            },
            // Common code used across multiple chunks
            common: {
              minChunks: 2,
              priority: 5,
              reuseExistingChunk: true,
              name: 'common'
            },
            // Large libraries in separate chunks
            react: {
              test: /[\\/]node_modules[\\/](react|react-dom)[\\/]/,
              name: 'react',
              priority: 20
            },
            lodash: {
              test: /[\\/]node_modules[\\/]lodash[\\/]/,
              name: 'lodash',
              priority: 20
            }
          }
        },
        // Runtime chunk for webpack runtime
        runtimeChunk: 'single'
      }
    };
    ```

    ### Dynamic Imports

    ```javascript
    // Load modules dynamically based on user action
    async function loadModule() {
      const module = await import('./heavy-module.js');
      module.initialize();
    }

    button.addEventListener('click', loadModule);

    // Import with magic comments for webpack
    const getUserLocale = () => {
      return navigator.language.split('-')[0];
    };

    async function loadTranslations() {
      const locale = getUserLocale();

      // Webpack magic comments
      const translations = await import(
        /* webpackChunkName: "translations-[request]" */
        /* webpackMode: "lazy" */
        `./translations/${locale}.json`
      );

      return translations.default;
    }
    ```

    ## Tree Shaking

    Eliminating dead code from your bundle.

    ### ES Modules for Tree Shaking

    ```javascript
    // utils.js - Use named exports
    export function usedFunction() {
      return 'This will be included';
    }

    export function unusedFunction() {
      return 'This will be removed';
    }

    // main.js - Import only what you need
    import { usedFunction } from './utils';

    console.log(usedFunction());
    // unusedFunction is not imported, will be tree-shaken
    ```

    ### Webpack Tree Shaking Configuration

    ```javascript
    // webpack.config.js
    module.exports = {
      mode: 'production', // Enables tree shaking
      optimization: {
        usedExports: true, // Mark unused exports
        minimize: true,    // Remove them
        sideEffects: false // Assume no side effects (unless specified)
      }
    };

    // package.json - Declare side effects
    {
      "name": "my-app",
      "sideEffects": [
        "*.css",
        "*.scss",
        "./src/polyfills.js"
      ]
    }
    ```

    ### Lodash Tree Shaking

    ```javascript
    // Bad: Imports entire lodash library (70KB)
    import _ from 'lodash';
    const result = _.debounce(fn, 300);

    // Good: Import specific function (2KB)
    import debounce from 'lodash/debounce';
    const result = debounce(fn, 300);

    // Better: Use lodash-es (ES modules version)
    import { debounce } from 'lodash-es';
    const result = debounce(fn, 300);
    ```

    ## Minification and Compression

    ### JavaScript Minification

    ```javascript
    // webpack.config.js
    const TerserPlugin = require('terser-webpack-plugin');

    module.exports = {
      optimization: {
        minimize: true,
        minimizer: [
          new TerserPlugin({
            terserOptions: {
              compress: {
                drop_console: true,    // Remove console.log
                drop_debugger: true,   // Remove debugger
                pure_funcs: ['console.info', 'console.debug']
              },
              mangle: {
                safari10: true         // Fix Safari 10 bug
              },
              output: {
                comments: false,       // Remove comments
                ascii_only: true       // Escape Unicode characters
              }
            },
            parallel: true,            // Use multiple CPUs
            extractComments: false     // Don't create .LICENSE files
          })
        ]
      }
    };
    ```

    ### Gzip Compression

    ```javascript
    // webpack.config.js
    const CompressionPlugin = require('compression-webpack-plugin');

    module.exports = {
      plugins: [
        new CompressionPlugin({
          algorithm: 'gzip',
          test: /\.(js|css|html|svg)$/,
          threshold: 8192,        // Only compress files > 8KB
          minRatio: 0.8          // Only compress if ratio > 80%
        })
      ]
    };

    // Express server serving gzipped files
    const express = require('express');
    const compression = require('compression');

    const app = express();

    // Compress responses
    app.use(compression({
      level: 6,  // Compression level (0-9)
      threshold: 1024  // Min size to compress
    }));

    app.use(express.static('dist'));
    ```

    ### Brotli Compression

    ```javascript
    // webpack.config.js
    const CompressionPlugin = require('compression-webpack-plugin');

    module.exports = {
      plugins: [
        // Gzip for older browsers
        new CompressionPlugin({
          filename: '[path][base].gz',
          algorithm: 'gzip',
          test: /\.(js|css|html|svg)$/
        }),
        // Brotli for modern browsers (better compression)
        new CompressionPlugin({
          filename: '[path][base].br',
          algorithm: 'brotliCompress',
          test: /\.(js|css|html|svg)$/,
          compressionOptions: {
            level: 11  // Max compression
          }
        })
      ]
    };

    // Nginx configuration
    // nginx.conf
    /*
    http {
      gzip on;
      gzip_types text/plain text/css application/json application/javascript;
      gzip_min_length 1000;

      brotli on;
      brotli_types text/plain text/css application/json application/javascript;
      brotli_comp_level 6;
    }
    */
    ```

    ## CSS Optimization

    ### Critical CSS

    ```javascript
    // Using critical package
    const critical = require('critical');

    critical.generate({
      inline: true,
      base: 'dist/',
      src: 'index.html',
      target: 'index.html',
      width: 1300,
      height: 900,
      dimensions: [
        {
          width: 375,
          height: 667
        },
        {
          width: 1920,
          height: 1080
        }
      ]
    });

    // Results in:
    /*
    <head>
      <style>
        /* Critical CSS inlined here */
        .hero { ... }
        .nav { ... }
      </style>

      <!-- Non-critical CSS loaded async -->
      <link rel="preload" as="style" href="styles.css"
            onload="this.onload=null;this.rel='stylesheet'">
      <noscript><link rel="stylesheet" href="styles.css"></noscript>
    </head>
    */
    ```

    ### Removing Unused CSS

    ```javascript
    // Using PurgeCSS with webpack
    const PurgeCSSPlugin = require('purgecss-webpack-plugin');
    const glob = require('glob-all');

    module.exports = {
      plugins: [
        new PurgeCSSPlugin({
          paths: glob.sync([
            path.join(__dirname, 'src/**/*.html'),
            path.join(__dirname, 'src/**/*.js'),
            path.join(__dirname, 'src/**/*.jsx')
          ]),
          safelist: {
            standard: ['active', 'disabled'],
            deep: [/^modal-/],  // Keep modal-* classes
            greedy: [/^btn-/]   // Keep btn-* and children
          }
        })
      ]
    };

    // Tailwind CSS (built-in purging)
    // tailwind.config.js
    module.exports = {
      content: [
        './src/**/*.{js,jsx,ts,tsx,html}',
      ],
      theme: {
        extend: {}
      }
    };
    ```

    ### CSS Minification

    ```javascript
    // webpack.config.js
    const MiniCssExtractPlugin = require('mini-css-extract-plugin');
    const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');

    module.exports = {
      module: {
        rules: [
          {
            test: /\.css$/,
            use: [
              MiniCssExtractPlugin.loader,
              'css-loader',
              'postcss-loader'
            ]
          }
        ]
      },
      plugins: [
        new MiniCssExtractPlugin({
          filename: '[name].[contenthash].css',
          chunkFilename: '[id].[contenthash].css'
        })
      ],
      optimization: {
        minimizer: [
          new CssMinimizerPlugin({
            minimizerOptions: {
              preset: [
                'default',
                {
                  discardComments: { removeAll: true },
                  normalizeUnicode: false
                }
              ]
            }
          })
        ]
      }
    };
    ```

    ## JavaScript Performance Patterns

    ### Debouncing

    ```javascript
    // Debounce: Execute after delay with no new calls
    function debounce(func, delay) {
      let timeoutId;

      return function(...args) {
        clearTimeout(timeoutId);

        timeoutId = setTimeout(() => {
          func.apply(this, args);
        }, delay);
      };
    }

    // Usage: Search input
    const searchInput = document.querySelector('#search');

    const performSearch = debounce((query) => {
      fetch(`/api/search?q=${query}`)
        .then(res => res.json())
        .then(results => displayResults(results));
    }, 300);

    searchInput.addEventListener('input', (e) => {
      performSearch(e.target.value);
    });
    ```

    ### Throttling

    ```javascript
    // Throttle: Execute at most once per interval
    function throttle(func, limit) {
      let inThrottle;

      return function(...args) {
        if (!inThrottle) {
          func.apply(this, args);
          inThrottle = true;

          setTimeout(() => {
            inThrottle = false;
          }, limit);
        }
      };
    }

    // Usage: Scroll event
    const handleScroll = throttle(() => {
      const scrollTop = window.pageYOffset;
      console.log('Scroll position:', scrollTop);

      // Update scroll indicator
      updateScrollIndicator(scrollTop);
    }, 100);

    window.addEventListener('scroll', handleScroll);
    ```

    ### Request Idle Callback

    ```javascript
    // Schedule non-critical work during idle time
    function scheduleIdleWork(tasks) {
      if ('requestIdleCallback' in window) {
        requestIdleCallback((deadline) => {
          while (deadline.timeRemaining() > 0 && tasks.length > 0) {
            const task = tasks.shift();
            task();
          }

          // Schedule remaining tasks
          if (tasks.length > 0) {
            scheduleIdleWork(tasks);
          }
        });
      } else {
        // Fallback for Safari
        setTimeout(() => {
          tasks.forEach(task => task());
        }, 1);
      }
    }

    // Usage: Analytics, prefetching
    const idleTasks = [
      () => sendAnalytics(),
      () => prefetchNextPage(),
      () => preloadImages()
    ];

    scheduleIdleWork(idleTasks);
    ```

    ### Web Workers

    ```javascript
    // main.js - Offload heavy computation to worker
    const worker = new Worker('worker.js');

    // Send data to worker
    worker.postMessage({
      type: 'PROCESS_DATA',
      data: largeDataset
    });

    // Receive results
    worker.onmessage = (e) => {
      console.log('Result:', e.data);
      displayResults(e.data);
    };

    // Handle errors
    worker.onerror = (error) => {
      console.error('Worker error:', error);
    };

    // worker.js - Process data without blocking UI
    self.onmessage = (e) => {
      const { type, data } = e.data;

      if (type === 'PROCESS_DATA') {
        // Heavy computation
        const result = processLargeDataset(data);

        // Send result back
        self.postMessage(result);
      }
    };

    function processLargeDataset(data) {
      return data.map(item => {
        // CPU-intensive operation
        return complexCalculation(item);
      });
    }
    ```

    ### Virtual Scrolling

    ```javascript
    // Only render visible items in long lists
    class VirtualList {
      constructor(container, items, itemHeight) {
        this.container = container;
        this.items = items;
        this.itemHeight = itemHeight;
        this.visibleItems = Math.ceil(container.clientHeight / itemHeight);
        this.startIndex = 0;

        this.render();
        this.container.addEventListener('scroll', () => this.handleScroll());
      }

      handleScroll() {
        this.startIndex = Math.floor(this.container.scrollTop / this.itemHeight);
        this.render();
      }

      render() {
        const endIndex = this.startIndex + this.visibleItems;
        const visibleItems = this.items.slice(this.startIndex, endIndex);

        this.container.innerHTML = `
          <div style="height: ${this.items.length * this.itemHeight}px; position: relative;">
            <div style="transform: translateY(${this.startIndex * this.itemHeight}px);">
              ${visibleItems.map(item => `
                <div style="height: ${this.itemHeight}px;">${item}</div>
              `).join('')}
            </div>
          </div>
        `;
      }
    }

    // Usage
    const items = Array.from({ length: 10000 }, (_, i) => `Item ${i}`);
    new VirtualList(document.querySelector('#list'), items, 50);
    ```

    ## Bundle Analysis

    ```javascript
    // webpack.config.js
    const BundleAnalyzerPlugin = require('webpack-bundle-analyzer').BundleAnalyzerPlugin;

    module.exports = {
      plugins: [
        new BundleAnalyzerPlugin({
          analyzerMode: 'static',
          openAnalyzer: false,
          reportFilename: 'bundle-report.html'
        })
      ]
    };

    // Run analysis
    // npm run build -- --analyze
    ```

    ## Best Practices Summary

    1. **Code Splitting**: Split by routes and components, not by arbitrary chunks
    2. **Tree Shaking**: Use ES modules, mark side effects, audit large dependencies
    3. **Compression**: Enable Brotli for modern browsers, Gzip as fallback
    4. **CSS**: Extract and minify CSS, remove unused styles, inline critical CSS
    5. **JavaScript Patterns**: Debounce user input, throttle scroll/resize, use web workers
    6. **Lazy Load**: Defer non-critical resources until needed
    7. **Monitor Bundle Size**: Set budgets and enforce them in CI/CD

    Optimize aggressively but measure the impact. Not all optimizations provide equal value.
  MARKDOWN
  lesson.key_concepts = ['code splitting', 'tree shaking', 'minification', 'Gzip', 'Brotli', 'critical CSS', 'PurgeCSS', 'debounce', 'throttle', 'web workers', 'virtual scrolling']
end

ModuleItem.find_or_create_by!(course_module: module2, item: lesson2_1) do |item|
  item.sequence_order = 1
  item.required = true
end

# ==========================================
# MODULE 3: Advanced Optimization
# ==========================================

module3 = CourseModule.find_or_create_by!(slug: 'advanced-optimization', course: perf_course) do |mod|
  mod.title = 'Advanced Optimization'
  mod.description = 'Caching strategies, CDN, Service Workers, HTTP/2, and performance monitoring'
  mod.sequence_order = 3
  mod.estimated_minutes = 140
  mod.published = true
  mod.learning_objectives = JSON.generate([
    "Implement effective caching strategies",
    "Configure CDN for optimal performance",
    "Build Progressive Web Apps with Service Workers",
    "Leverage HTTP/2 and HTTP/3 features",
    "Monitor performance and enforce budgets"
  ])
end

lesson3_1 = CourseLesson.find_or_create_by!(title: "Advanced Performance Techniques") do |lesson|
  lesson.reading_time_minutes = 30
  lesson.content = <<~MARKDOWN
    # Advanced Performance Techniques

    Advanced optimization techniques can dramatically improve performance through caching, CDNs, and modern protocols.

    ## HTTP Caching Strategies

    Effective caching reduces server load and improves load times for returning visitors.

    ### Cache-Control Headers

    ```javascript
    // Express.js caching examples
    const express = require('express');
    const app = express();

    // Immutable static assets (versioned files)
    app.use('/static', express.static('public', {
      maxAge: '1y',
      immutable: true,
      setHeaders: (res, path) => {
        res.setHeader('Cache-Control', 'public, max-age=31536000, immutable');
      }
    }));

    // HTML - no cache (always validate)
    app.get('/', (req, res) => {
      res.setHeader('Cache-Control', 'no-cache, must-revalidate');
      res.sendFile('index.html');
    });

    // API responses - short cache
    app.get('/api/data', (req, res) => {
      res.setHeader('Cache-Control', 'public, max-age=300'); // 5 minutes
      res.json({ data: 'response' });
    });

    // User-specific data - no store
    app.get('/api/user', (req, res) => {
      res.setHeader('Cache-Control', 'private, no-store');
      res.json({ user: 'data' });
    });
    ```

    ### Cache-Control Directives

    ```
    Cache-Control: public               # Can be cached by browsers and CDNs
    Cache-Control: private              # Only browser cache (not CDN)
    Cache-Control: no-cache             # Validate before using cached version
    Cache-Control: no-store             # Never cache
    Cache-Control: max-age=3600         # Cache for 1 hour
    Cache-Control: s-maxage=7200        # CDN cache for 2 hours
    Cache-Control: must-revalidate      # Validate after expiry
    Cache-Control: immutable            # Never revalidate (versioned assets)
    ```

    ### ETag and Last-Modified

    ```javascript
    // Server: Set ETag and Last-Modified
    app.get('/api/data', async (req, res) => {
      const data = await fetchData();
      const etag = generateETag(data);
      const lastModified = data.updatedAt;

      // Check if client has current version
      if (req.headers['if-none-match'] === etag) {
        return res.status(304).end(); // Not Modified
      }

      res.setHeader('ETag', etag);
      res.setHeader('Last-Modified', lastModified.toUTCString());
      res.setHeader('Cache-Control', 'public, max-age=0, must-revalidate');
      res.json(data);
    });

    function generateETag(data) {
      const crypto = require('crypto');
      return crypto
        .createHash('md5')
        .update(JSON.stringify(data))
        .digest('hex');
    }
    ```

    ### Versioned Assets Pattern

    ```javascript
    // webpack.config.js - Add content hash to filenames
    module.exports = {
      output: {
        filename: '[name].[contenthash].js',
        chunkFilename: '[name].[contenthash].chunk.js'
      },
      plugins: [
        new MiniCssExtractPlugin({
          filename: '[name].[contenthash].css'
        })
      ]
    };

    // HTML template with versioned assets
    /*
    <link rel="stylesheet" href="/css/main.a3f2bc1d.css">
    <script src="/js/main.d7e9f2a1.js"></script>
    */

    // Cache headers for versioned assets
    app.use('/css', express.static('dist/css', {
      maxAge: '1y',
      immutable: true
    }));
    ```

    ## CDN Configuration

    ### Choosing CDN Strategy

    ```javascript
    // Option 1: Full site on CDN (static site)
    // - Host entire site on CDN (Netlify, Vercel, Cloudflare Pages)
    // - Best for: JAMstack, static sites, SPAs

    // Option 2: CDN for assets only
    // - Origin server serves HTML
    // - CDN serves static assets (JS, CSS, images)
    const CDN_URL = 'https://cdn.example.com';

    module.exports = {
      output: {
        publicPath: process.env.NODE_ENV === 'production'
          ? `${CDN_URL}/`
          : '/'
      }
    };

    // Option 3: Full CDN with origin pull
    // - CDN caches responses from origin
    // - Best for: Dynamic sites with caching
    ```

    ### CDN Cache Configuration

    ```javascript
    // Cloudflare Workers - Custom caching logic
    addEventListener('fetch', event => {
      event.respondWith(handleRequest(event.request));
    });

    async function handleRequest(request) {
      const url = new URL(request.url);

      // Cache API responses for 5 minutes
      if (url.pathname.startsWith('/api/')) {
        const cache = caches.default;
        let response = await cache.match(request);

        if (!response) {
          response = await fetch(request);

          // Clone response and cache it
          const responseToCache = response.clone();
          const headers = new Headers(responseToCache.headers);
          headers.set('Cache-Control', 'public, max-age=300');

          const cachedResponse = new Response(responseToCache.body, {
            status: responseToCache.status,
            statusText: responseToCache.statusText,
            headers
          });

          event.waitUntil(cache.put(request, cachedResponse));
        }

        return response;
      }

      return fetch(request);
    }
    ```

    ### Multi-CDN Strategy

    ```javascript
    // Use multiple CDNs for redundancy
    const CDN_PROVIDERS = [
      'https://cdn1.example.com',
      'https://cdn2.example.com',
      'https://cdn3.example.com'
    ];

    function getCDNUrl(asset, userRegion) {
      // Route based on geography
      if (userRegion === 'eu') return `${CDN_PROVIDERS[0]}/${asset}`;
      if (userRegion === 'asia') return `${CDN_PROVIDERS[1]}/${asset}`;
      return `${CDN_PROVIDERS[2]}/${asset}`;
    }

    // Fallback on CDN failure
    function loadScript(src) {
      return new Promise((resolve, reject) => {
        const script = document.createElement('script');
        script.src = src;
        script.onload = resolve;
        script.onerror = () => {
          // Try fallback CDN
          script.src = src.replace(CDN_PROVIDERS[0], CDN_PROVIDERS[1]);
          script.onerror = reject;
        };
        document.head.appendChild(script);
      });
    }
    ```

    ## Service Workers and PWA

    ### Basic Service Worker

    ```javascript
    // sw.js - Service Worker
    const CACHE_NAME = 'my-app-v1';
    const urlsToCache = [
      '/',
      '/styles/main.css',
      '/scripts/main.js',
      '/images/logo.png'
    ];

    // Install: Cache static resources
    self.addEventListener('install', event => {
      event.waitUntil(
        caches.open(CACHE_NAME)
          .then(cache => cache.addAll(urlsToCache))
          .then(() => self.skipWaiting())
      );
    });

    // Activate: Clean up old caches
    self.addEventListener('activate', event => {
      event.waitUntil(
        caches.keys().then(cacheNames => {
          return Promise.all(
            cacheNames.map(cacheName => {
              if (cacheName !== CACHE_NAME) {
                return caches.delete(cacheName);
              }
            })
          );
        }).then(() => self.clients.claim())
      );
    });

    // Fetch: Cache-first strategy
    self.addEventListener('fetch', event => {
      event.respondWith(
        caches.match(event.request)
          .then(response => {
            return response || fetch(event.request);
          })
      );
    });

    // Register service worker
    // main.js
    if ('serviceWorker' in navigator) {
      navigator.serviceWorker.register('/sw.js')
        .then(registration => {
          console.log('SW registered:', registration);
        })
        .catch(error => {
          console.log('SW registration failed:', error);
        });
    }
    ```

    ### Caching Strategies

    ```javascript
    // Strategy 1: Cache First (offline-first)
    self.addEventListener('fetch', event => {
      event.respondWith(
        caches.match(event.request)
          .then(response => response || fetch(event.request))
      );
    });

    // Strategy 2: Network First (fresh content)
    self.addEventListener('fetch', event => {
      event.respondWith(
        fetch(event.request)
          .catch(() => caches.match(event.request))
      );
    });

    // Strategy 3: Stale-While-Revalidate (best of both)
    self.addEventListener('fetch', event => {
      event.respondWith(
        caches.open(CACHE_NAME).then(cache => {
          return cache.match(event.request).then(response => {
            const fetchPromise = fetch(event.request).then(networkResponse => {
              cache.put(event.request, networkResponse.clone());
              return networkResponse;
            });

            return response || fetchPromise;
          });
        })
      );
    });

    // Strategy 4: Network Only (dynamic content)
    self.addEventListener('fetch', event => {
      if (event.request.url.includes('/api/')) {
        event.respondWith(fetch(event.request));
      }
    });

    // Combined strategy based on request type
    self.addEventListener('fetch', event => {
      const { request } = event;
      const url = new URL(request.url);

      // API requests: Network first
      if (url.pathname.startsWith('/api/')) {
        event.respondWith(networkFirst(request));
      }
      // Static assets: Cache first
      else if (url.pathname.match(/\.(js|css|png|jpg|svg)$/)) {
        event.respondWith(cacheFirst(request));
      }
      // HTML: Stale while revalidate
      else {
        event.respondWith(staleWhileRevalidate(request));
      }
    });
    ```

    ### Background Sync

    ```javascript
    // Queue failed requests and retry when online
    // sw.js
    self.addEventListener('sync', event => {
      if (event.tag === 'sync-posts') {
        event.waitUntil(syncPosts());
      }
    });

    async function syncPosts() {
      const db = await openDB();
      const posts = await db.getAll('pending-posts');

      for (const post of posts) {
        try {
          await fetch('/api/posts', {
            method: 'POST',
            body: JSON.stringify(post)
          });
          await db.delete('pending-posts', post.id);
        } catch (error) {
          console.error('Sync failed:', error);
        }
      }
    }

    // main.js - Request background sync
    async function createPost(data) {
      try {
        await fetch('/api/posts', {
          method: 'POST',
          body: JSON.stringify(data)
        });
      } catch (error) {
        // Store for later sync
        const db = await openDB();
        await db.add('pending-posts', data);

        // Register sync
        const registration = await navigator.serviceWorker.ready;
        await registration.sync.register('sync-posts');
      }
    }
    ```

    ## HTTP/2 and HTTP/3

    ### HTTP/2 Features

    ```javascript
    // Server Push (HTTP/2)
    // Node.js HTTP/2 server
    const http2 = require('http2');
    const fs = require('fs');

    const server = http2.createSecureServer({
      key: fs.readFileSync('key.pem'),
      cert: fs.readFileSync('cert.pem')
    });

    server.on('stream', (stream, headers) => {
      if (headers[':path'] === '/') {
        // Push critical resources
        stream.pushStream({ ':path': '/styles.css' }, (err, pushStream) => {
          pushStream.respondWithFile('styles.css');
        });

        stream.pushStream({ ':path': '/app.js' }, (err, pushStream) => {
          pushStream.respondWithFile('app.js');
        });

        // Respond with HTML
        stream.respondWithFile('index.html');
      }
    });

    server.listen(443);
    ```

    ### HTTP/2 Best Practices

    ```javascript
    // 1. No need to concatenate files (multiplexing handles it)
    // HTTP/1.1: Bundle all CSS/JS
    // HTTP/2: Send individual files

    // 2. No need for domain sharding
    // HTTP/1.1: Use multiple subdomains to bypass connection limit
    // HTTP/2: Single connection is more efficient

    // 3. Inline only critical CSS
    // HTTP/2 can efficiently load multiple small files

    // 4. Use server push carefully
    // Only push resources needed for initial render
    // Don't push if client already has cached version

    // Nginx HTTP/2 configuration
    /*
    server {
      listen 443 ssl http2;

      # Enable HTTP/2 push
      http2_push /css/main.css;
      http2_push /js/main.js;

      # Enable HTTP/2 multiplexing
      http2_max_concurrent_streams 128;
    }
    */
    ```

    ### HTTP/3 (QUIC)

    ```javascript
    // Enable HTTP/3 with Cloudflare
    // Cloudflare automatically enables HTTP/3 for all sites
    // No code changes needed on client side

    // Check if browser supports HTTP/3
    if ('quic' in navigator) {
      console.log('HTTP/3 supported');
    }

    // Nginx HTTP/3 configuration
    /*
    server {
      listen 443 ssl http3 reuseport;
      listen 443 ssl http2;

      # Advertise HTTP/3 support
      add_header Alt-Svc 'h3=":443"; ma=86400';
    }
    */
    ```

    ## Performance Monitoring

    ### Real User Monitoring (RUM)

    ```javascript
    // Collect real user metrics
    class PerformanceMonitor {
      constructor(endpoint) {
        this.endpoint = endpoint;
        this.collectMetrics();
      }

      collectMetrics() {
        // Core Web Vitals
        this.observeLCP();
        this.observeFID();
        this.observeCLS();

        // Navigation timing
        window.addEventListener('load', () => {
          this.collectNavigationTiming();
        });
      }

      observeLCP() {
        new PerformanceObserver((list) => {
          const entries = list.getEntries();
          const lastEntry = entries[entries.length - 1];

          this.sendMetric('LCP', lastEntry.renderTime || lastEntry.loadTime);
        }).observe({ type: 'largest-contentful-paint', buffered: true });
      }

      observeFID() {
        new PerformanceObserver((list) => {
          const firstInput = list.getEntries()[0];
          const FID = firstInput.processingStart - firstInput.startTime;

          this.sendMetric('FID', FID);
        }).observe({ type: 'first-input', buffered: true });
      }

      observeCLS() {
        let clsScore = 0;

        new PerformanceObserver((list) => {
          for (const entry of list.getEntries()) {
            if (!entry.hadRecentInput) {
              clsScore += entry.value;
            }
          }

          this.sendMetric('CLS', clsScore);
        }).observe({ type: 'layout-shift', buffered: true });
      }

      collectNavigationTiming() {
        const nav = performance.getEntriesByType('navigation')[0];

        this.sendMetric('TTFB', nav.responseStart - nav.requestStart);
        this.sendMetric('DOMContentLoaded', nav.domContentLoadedEventEnd - nav.domContentLoadedEventStart);
        this.sendMetric('Load', nav.loadEventEnd - nav.loadEventStart);
      }

      sendMetric(name, value) {
        // Use sendBeacon for reliability
        navigator.sendBeacon(this.endpoint, JSON.stringify({
          metric: name,
          value: value,
          url: window.location.href,
          userAgent: navigator.userAgent,
          timestamp: Date.now()
        }));
      }
    }

    // Initialize
    new PerformanceMonitor('/api/metrics');
    ```

    ### Synthetic Monitoring

    ```javascript
    // Lighthouse CI configuration
    // lighthouserc.js
    module.exports = {
      ci: {
        collect: {
          numberOfRuns: 3,
          url: [
            'http://localhost:3000/',
            'http://localhost:3000/products',
            'http://localhost:3000/checkout'
          ]
        },
        assert: {
          assertions: {
            'categories:performance': ['error', { minScore: 0.9 }],
            'categories:accessibility': ['warn', { minScore: 0.9 }],
            'first-contentful-paint': ['error', { maxNumericValue: 2000 }],
            'largest-contentful-paint': ['error', { maxNumericValue: 2500 }],
            'cumulative-layout-shift': ['error', { maxNumericValue: 0.1 }]
          }
        },
        upload: {
          target: 'temporary-public-storage'
        }
      }
    };

    // Run in CI/CD
    // npm install -g @lhci/cli
    // lhci autorun
    ```

    ### Performance Budgets

    ```javascript
    // webpack.config.js - Enforce bundle size limits
    module.exports = {
      performance: {
        maxAssetSize: 244000,      // 244 KB
        maxEntrypointSize: 244000,
        hints: 'error',
        assetFilter: (assetFilename) => {
          return assetFilename.endsWith('.js') || assetFilename.endsWith('.css');
        }
      }
    };

    // package.json - Bundle size tracking
    {
      "scripts": {
        "build": "webpack",
        "size": "size-limit"
      },
      "size-limit": [
        {
          "path": "dist/main.js",
          "limit": "200 KB"
        },
        {
          "path": "dist/main.css",
          "limit": "50 KB"
        }
      ]
    }

    // .github/workflows/performance.yml
    /*
    name: Performance
    on: [pull_request]
    jobs:
      bundle-size:
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
          - run: npm ci
          - run: npm run build
          - uses: andresz1/size-limit-action@v1
            with:
              github_token: ${{ secrets.GITHUB_TOKEN }}
    */
    ```

    ### Custom Performance Marks

    ```javascript
    // Mark important events
    performance.mark('api-request-start');

    fetch('/api/data')
      .then(res => res.json())
      .then(data => {
        performance.mark('api-request-end');
        performance.measure('api-request', 'api-request-start', 'api-request-end');

        const measure = performance.getEntriesByName('api-request')[0];
        console.log('API request took:', measure.duration, 'ms');

        // Send to analytics
        analytics.track('api_timing', {
          duration: measure.duration,
          endpoint: '/api/data'
        });
      });

    // Measure React component render
    class MyComponent extends React.Component {
      componentDidMount() {
        performance.mark('component-mount-end');
        performance.measure('component-mount', 'component-mount-start', 'component-mount-end');
      }

      render() {
        performance.mark('component-mount-start');
        return <div>Component</div>;
      }
    }
    ```

    ## Performance Checklist

    ### Before Launch

    - [ ] Core Web Vitals meet targets (LCP < 2.5s, FID < 100ms, CLS < 0.1)
    - [ ] Lighthouse score > 90
    - [ ] Images optimized (WebP/AVIF, responsive, lazy loaded)
    - [ ] Fonts optimized (preloaded, font-display: swap)
    - [ ] JavaScript code-split and tree-shaken
    - [ ] CSS critical path optimized
    - [ ] Compression enabled (Brotli + Gzip)
    - [ ] Caching headers configured
    - [ ] CDN configured and tested
    - [ ] Service Worker implemented (for PWA)
    - [ ] Performance budgets enforced

    ### Continuous Monitoring

    - [ ] RUM collecting Core Web Vitals
    - [ ] Synthetic monitoring in CI/CD
    - [ ] Performance budgets in place
    - [ ] Alerts for performance regressions
    - [ ] Regular Lighthouse audits
    - [ ] Bundle size tracking
    - [ ] Error tracking (failed resource loads)

    ## Best Practices Summary

    1. **Caching**: Use immutable caching for versioned assets, validate HTML
    2. **CDN**: Serve static assets from CDN, use multi-CDN for critical applications
    3. **Service Workers**: Implement offline-first for static content, network-first for dynamic
    4. **HTTP/2**: Enable and use server push judiciously
    5. **Monitoring**: Collect RUM data, run synthetic tests in CI/CD
    6. **Budgets**: Set and enforce performance budgets for every release
    7. **Iterate**: Performance optimization is continuous, not one-time

    The web performance landscape evolves rapidly. Stay informed about new browser APIs, compression algorithms, and protocols.
  MARKDOWN
  lesson.key_concepts = ['HTTP caching', 'Cache-Control', 'CDN', 'Service Workers', 'PWA', 'HTTP/2', 'HTTP/3', 'RUM', 'synthetic monitoring', 'performance budgets', 'background sync']
end

ModuleItem.find_or_create_by!(course_module: module3, item: lesson3_1) do |item|
  item.sequence_order = 1
  item.required = true
end

puts "  ✅ Created Web Performance Optimization course with comprehensive lessons"
puts "  📊 Modules: #{perf_course.course_modules.count}"
puts "  📚 Total Lessons: 3"
puts "  ⏱️  Total Time: 100 minutes"
