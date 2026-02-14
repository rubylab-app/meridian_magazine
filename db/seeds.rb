puts "Seeding Meridian Magazine demo data..."

# =============================================================================
# Users — 3 staff members with different roles
# =============================================================================
users = {}

users[:ana] = User.find_or_create_by!(email: "ana@meridian.com") do |u|
  u.name = "Ana García"
  u.role = :admin
  u.bio = "Founder and editor-in-chief of Meridian Magazine. Over 15 years of experience in digital publishing and media strategy."
  u.avatar_url = "https://i.pravatar.cc/150?u=ana"
  u.website = "https://anagarcia.dev"
  u.api_token = "mk_live_ana_9f8e7d6c5b4a3210"
  u.active = true
end

users[:carlos] = User.find_or_create_by!(email: "carlos@meridian.com") do |u|
  u.name = "Carlos López"
  u.role = :editor
  u.bio = "Senior editor covering technology and science. Former staff writer at Wired en Español."
  u.avatar_url = "https://i.pravatar.cc/150?u=carlos"
  u.website = "https://carloslopez.blog"
  u.api_token = "mk_live_carlos_1a2b3c4d5e6f7890"
  u.active = true
end

users[:maria] = User.find_or_create_by!(email: "maria@meridian.com") do |u|
  u.name = "María Torres"
  u.role = :author
  u.bio = "Freelance journalist and culture critic. Writes about design, art, and the intersection of creativity and technology."
  u.avatar_url = "https://i.pravatar.cc/150?u=maria"
  u.website = "https://mariatorres.com"
  u.api_token = "mk_live_maria_abcdef1234567890"
  u.active = true
end

puts "  Created #{User.count} users"

# =============================================================================
# Categories — 6 editorial sections
# =============================================================================
categories = {}

[
  { name: "Technology", slug: "technology", description: "Software engineering, AI, developer tools, and the tech industry.",
    position: 1, color: "#3B82F6", },
  { name: "Design", slug: "design", description: "UI/UX, typography, visual design, and creative tools.", position: 2,
    color: "#8B5CF6", },
  { name: "Business", slug: "business", description: "Startups, leadership, remote work, and the future of organizations.",
    position: 3, color: "#10B981", },
  { name: "Science", slug: "science", description: "Research breakthroughs, climate, space exploration, and health.",
    position: 4, color: "#F59E0B", },
  { name: "Culture", slug: "culture", description: "Books, film, music, and the stories that shape how we live.", position: 5,
    color: "#EF4444", },
  { name: "Lifestyle", slug: "lifestyle", description: "Productivity, wellness, travel, and living intentionally.", position: 6,
    color: "#EC4899", },
].each do |attrs|
  categories[attrs[:slug].to_sym] = Category.find_or_create_by!(slug: attrs[:slug]) do |c|
    c.name = attrs[:name]
    c.description = attrs[:description]
    c.position = attrs[:position]
    c.color = attrs[:color]
  end
end

puts "  Created #{Category.count} categories"

# =============================================================================
# Tags — 15 topic tags
# =============================================================================
tags = {}

%w[
  ruby rails javascript css ai machine-learning startup remote-work
  open-source devtools climate space productivity design-systems typography
].each do |slug|
  tags[slug.to_sym] = Tag.find_or_create_by!(slug: slug) do |t|
    t.name = slug.tr("-", " ").titleize
  end
end

puts "  Created #{Tag.count} tags"

# =============================================================================
# Articles — 30 realistic articles spread over 6 months
# =============================================================================
articles_data = [
  # --- PUBLISHED: Technology ---
  {
    title: "Why Ruby on Rails Still Matters in 2025",
    excerpt: "Rails isn't going anywhere. Here's why the framework continues to thrive in an era of JavaScript fatigue.",
    body: "When DHH first released Ruby on Rails in 2004, the web development landscape was a very different place. Two decades later, Rails has evolved from a scrappy upstart into a mature, battle-tested framework that powers some of the most successful companies on the planet.\n\nShopify processes billions of dollars in transactions through Rails. GitHub manages the world's largest collection of source code with it. Hey.com reimagined email on top of it. These aren't legacy systems clinging to old technology — they're modern applications that chose Rails deliberately.\n\nThe secret to Rails' longevity isn't any single feature. It's the philosophy: convention over configuration, programmer happiness, and the belief that one person should be able to build a complete web application. In an era where frontend complexity has spiraled out of control, this philosophy feels more relevant than ever.\n\nRails 8 doubles down on this vision. With Solid Cable, Solid Cache, and Solid Queue, the framework eliminates the need for Redis in most applications. Kamal 2 makes deployment as simple as a single command. And Turbo continues to blur the line between server-rendered and single-page applications.\n\nThe numbers tell the story: RubyGems downloads are at an all-time high, Rails job postings have stabilized after years of decline, and the community is producing some of its best work ever. The one-person framework isn't just surviving — it's thriving.",
    status: :published, featured: true,
    user: :ana, category: :technology, tags: %i[ruby rails open-source],
    published_at: 3.days.ago,
  },
  {
    title: "Building Admin Panels Without the Boilerplate",
    excerpt: "How convention-over-configuration engines like IronAdmin eliminate weeks of repetitive CRUD work.",
    body: "Every Rails developer has been there: you finish building the core of your application, and then you realize you need an admin panel. What follows is days — sometimes weeks — of writing repetitive CRUD controllers, index views, form builders, and filter logic.\n\nThe admin panel paradox is that it's simultaneously essential and boring. No one starts a company to build data tables, but every company needs them. This is exactly the kind of problem that Rails' philosophy of convention over configuration was designed to solve.\n\nEnter the new generation of admin engines. Instead of generating scaffolds that you'll spend forever customizing, these tools introspect your models and generate complete, production-ready interfaces automatically. Define a resource class, declare a few overrides, and you have a fully functional admin panel with search, filters, pagination, and export — all matching your brand.\n\nThe key insight is that 80% of admin panel code is identical across applications. The same data tables, the same filter patterns, the same form layouts. By extracting these patterns into a well-designed engine, you can focus your time on the 20% that's actually unique to your business.\n\nThis isn't about low-code platforms or drag-and-drop builders. It's about smart defaults and escape hatches. When the convention works, you write zero code. When it doesn't, you override exactly what you need.",
    status: :published, featured: true,
    user: :carlos, category: :technology, tags: %i[ruby rails devtools],
    published_at: 1.week.ago,
  },
  {
    title: "The Rise of Local-First AI Models",
    excerpt: "Running LLMs on your laptop is no longer a novelty — it's becoming a serious development workflow.",
    body: "Two years ago, running a large language model required a cloud GPU and a hefty monthly bill. Today, you can run surprisingly capable models on a MacBook Air. This shift from cloud-first to local-first AI isn't just a technical curiosity — it's reshaping how developers think about AI integration.\n\nThe numbers are striking. Llama 3.2 runs at 30 tokens per second on an M3 chip. Mistral's small models fit comfortably in 8GB of RAM. And quantization techniques continue to shrink models without destroying their capabilities.\n\nFor developers, this means AI-powered features that work offline, respect user privacy, and cost nothing to run. Imagine a code editor that provides intelligent completions without sending your proprietary code to a third-party API. Or a note-taking app that summarizes your documents entirely on-device.\n\nThe tooling ecosystem is maturing rapidly. Ollama provides a Docker-like experience for model management. LM Studio offers a polished GUI for experimentation. And frameworks like llama.cpp and MLX make it straightforward to integrate local inference into any application.\n\nThe implications extend beyond developer tools. Local-first AI enables applications in healthcare, legal, and finance where data sovereignty is non-negotiable. It's the difference between 'we promise we won't read your data' and 'your data never leaves your device.'",
    status: :published, featured: false,
    user: :carlos, category: :technology, tags: %i[ai machine-learning],
    published_at: 2.weeks.ago,
  },
  {
    title: "Understanding Stimulus: JavaScript Without the Complexity",
    excerpt: "Stimulus proves you don't need a virtual DOM to build interactive interfaces.",
    body: "In a world dominated by React, Vue, and Svelte, Stimulus takes a radically different approach to JavaScript. Instead of owning the entire page and managing state through a virtual DOM, Stimulus sprinkles behavior onto existing HTML. The result is surprisingly powerful.\n\nThe core concept is simple: controllers connect to DOM elements through data attributes. A controller is just a JavaScript class with lifecycle callbacks and action methods. There's no build step required, no JSX to learn, no state management library to choose.\n\nConsider a dropdown menu. In React, you'd create a component with useState for open/closed state, useRef for click-outside detection, and useEffect for cleanup. In Stimulus, you write a controller with toggle and hide actions, connect it to your HTML with data-controller='dropdown', and you're done.\n\nThis approach shines in server-rendered applications where the HTML is the source of truth. You don't need to serialize your data into JSON, pass it to a client-side framework, and render it again. The server renders the HTML once, and Stimulus adds interactivity where needed.\n\nThe trade-off is real: Stimulus isn't the right choice for highly interactive applications like spreadsheets or design tools. But for the vast majority of web applications — forms, navigation, modals, filters — it's more than enough.",
    status: :published, featured: false,
    user: :ana, category: :technology, tags: %i[javascript rails],
    published_at: 3.weeks.ago,
  },
  {
    title: "Open Source Maintainership: A Survival Guide",
    excerpt: "Lessons learned from maintaining a popular Ruby gem for three years.",
    body: "Nobody tells you what it's like to maintain an open source project that people actually use. The initial rush of stars and pull requests feels incredible. Then reality sets in: the issues pile up, the feature requests conflict with each other, and strangers on the internet have strong opinions about your API design.\n\nAfter three years of maintaining a Ruby gem with over 5,000 stars, here's what I've learned about surviving — and even enjoying — the experience.\n\nFirst, ruthlessly define your scope. The most dangerous words in open source are 'it would be nice if...' Every feature you add is a feature you maintain forever. Say no more than you say yes, and document why.\n\nSecond, invest in your test suite and CI pipeline. The only way to confidently merge pull requests from strangers is to have tests you trust. If a PR passes CI, it should be safe to merge. If it isn't, your CI is broken, not the PR.\n\nThird, write contributing guidelines that are honest about your response times and review process. Setting expectations upfront prevents frustration on both sides.\n\nFourth, take breaks. Open source guilt is real — the feeling that you should be triaging issues instead of living your life. The project will survive a week without your attention. If it won't, that's a bus factor problem, not a vacation problem.\n\nFinally, remember why you started. You built something useful. People depend on it. That's worth celebrating, even on the hard days.",
    status: :published, featured: false,
    user: :maria, category: :technology, tags: %i[open-source ruby],
    published_at: 1.month.ago,
  },

  # --- PUBLISHED: Design ---
  {
    title: "Design Systems Are Infrastructure, Not Decoration",
    excerpt: "Why treating your design system as a product — not a project — changes everything.",
    body: "Most design systems fail. Not because they're poorly designed, but because they're poorly positioned within the organization. They start as a Figma library, grow into a component collection, and eventually stagnate because nobody owns them.\n\nThe design systems that succeed — Shopify's Polaris, GitHub's Primer, Atlassian's Design System — treat themselves as internal products. They have dedicated teams, release cycles, versioning, migration guides, and customer support (where the customers are internal developers and designers).\n\nThis shift in mindset changes everything. When a design system is a project, it's something you build and move on from. When it's a product, it's something you continuously maintain, improve, and advocate for.\n\nThe technical implications are significant. A product-grade design system needs semantic versioning, automated visual regression testing, documentation that actually stays current, and a contribution model that doesn't require the core team to be a bottleneck.\n\nBut the organizational implications are even bigger. A design system product needs a roadmap, stakeholders, success metrics, and executive sponsorship. It needs someone whose job title includes the words 'design system' — not a committee of volunteers who squeeze in contributions between their real work.\n\nThe ROI is undeniable. Teams using mature design systems ship features 30-40% faster, maintain greater visual consistency, and onboard new designers and developers in days instead of weeks.",
    status: :published, featured: true,
    user: :maria, category: :design, tags: %i[design-systems css],
    published_at: 5.days.ago,
  },
  {
    title: "The Quiet Revolution in Web Typography",
    excerpt: "Variable fonts, fluid type scales, and the death of the 16px default.",
    body: "For decades, web typography was an afterthought. Designers picked from a handful of web-safe fonts, set a base size of 16px, and moved on. The web was for reading, but nobody optimized for it.\n\nThat era is over. Variable fonts, fluid type scales, and modern CSS have transformed web typography from a limitation into a superpower.\n\nVariable fonts are the single biggest advancement. Instead of loading four separate font files (regular, bold, italic, bold italic), you load one file that contains the entire design space. Want a weight of 450? Done. A width of 87%? No problem. This isn't just about file size savings — it's about typographic expression that was previously impossible.\n\nFluid type scales take responsive typography beyond breakpoints. Instead of jumping from 16px to 18px at 768px, your type size flows smoothly from small screens to large ones using CSS clamp(). The result is text that looks intentional at every viewport width.\n\nThe tooling has caught up too. Fontshare and Google Fonts offer high-quality variable fonts for free. Utopia generates fluid type scales with a visual calculator. And modern browsers support every feature you need.\n\nThe impact on reading experience is measurable. Sites with well-tuned typography see longer session durations, lower bounce rates, and higher engagement. When text is comfortable to read, people read more of it.",
    status: :published, featured: false,
    user: :maria, category: :design, tags: %i[typography css],
    published_at: 2.weeks.ago,
  },

  # --- PUBLISHED: Business ---
  {
    title: "The Solo Developer Renaissance",
    excerpt: "Modern tools make it possible for one person to build, deploy, and scale a profitable SaaS.",
    body: "We're living in a golden age for solo developers. The combination of powerful frameworks, managed infrastructure, and AI-assisted coding has compressed what used to require a team of ten into what one person can accomplish on a Sunday afternoon.\n\nConsider what a solo developer in 2025 has access to: Rails or Next.js for the application, Tailwind for styling, SQLite or managed Postgres for the database, Kamal or Fly.io for deployment, Stripe for payments, Resend for email, and AI for everything else. The entire stack costs less than $50/month until you have real revenue.\n\nThe economics are remarkable. A solo developer with 500 paying customers at $29/month generates $174,000/year in recurring revenue. With minimal infrastructure costs and no payroll, the margins are extraordinary.\n\nBut the solo developer renaissance isn't just about money. It's about autonomy. No standups, no sprint planning, no consensus-seeking. You identify a problem, build a solution, and ship it. The feedback loop is measured in hours, not quarters.\n\nThe most successful solo developers share a common trait: they pick boring problems. They don't build the next social network or marketplace. They build invoice generators, scheduling tools, email templates, and admin panels. They find a niche so specific that big companies ignore it, and they serve it obsessively.\n\nThe tools have never been better. The only question is: what will you build?",
    status: :published, featured: false,
    user: :ana, category: :business, tags: %i[startup remote-work rails],
    published_at: 10.days.ago,
  },
  {
    title: "Remote Work Isn't the Future — It's the Present",
    excerpt: "Three years of data show that distributed teams outperform when given the right tools and trust.",
    body: "The great remote work experiment of 2020 has produced enough data to settle the debate. Distributed teams that invest in asynchronous communication, clear documentation, and outcome-based management consistently outperform their in-office counterparts on every metric that matters.\n\nThe evidence is compelling. GitLab, a fully remote company with over 2,000 employees across 65 countries, ships software faster than most companies a fraction of their size. Their secret isn't a magic tool — it's a 2,000-page handbook that documents every process, decision, and cultural norm.\n\nThe key insight is that remote work doesn't fail because of distance. It fails because of poor communication. And poor communication isn't solved by forcing people into an office — it's solved by writing things down.\n\nThe best remote teams share several practices. They default to asynchronous communication, reserving synchronous meetings for discussions that genuinely benefit from real-time interaction. They document decisions, not just outcomes. They use video sparingly and intentionally. And they measure results, not hours.\n\nThe companies dragging employees back to offices aren't responding to data. They're responding to a loss of control. When managers can't see people working, they assume people aren't working. This says more about management philosophy than productivity.\n\nThe future belongs to companies that trust their people. The data is clear.",
    status: :published, featured: false,
    user: :carlos, category: :business, tags: %i[remote-work startup],
    published_at: 3.weeks.ago,
  },

  # --- PUBLISHED: Science ---
  {
    title: "The Year Fusion Energy Got Serious",
    excerpt: "Private companies are racing to achieve net energy gain. The timeline is no longer 'always 30 years away.'",
    body: "For decades, fusion energy was the punchline of a physics joke: it's always 30 years away. But something shifted in the last two years. Private investment in fusion startups exceeded $6 billion, multiple companies demonstrated net energy gain in laboratory conditions, and the first commercial pilot plants broke ground.\n\nThe physics hasn't changed — fusion still requires heating plasma to 100 million degrees and confining it long enough for hydrogen isotopes to fuse. What changed is the engineering. High-temperature superconducting magnets, advanced materials, and machine learning-optimized plasma control have turned theoretical feasibility into practical progress.\n\nCommonwealth Fusion Systems, a spinout from MIT, is building SPARC — a compact tokamak that aims to produce more energy than it consumes by 2026. Their secret weapon is a new generation of superconducting magnets that produce stronger magnetic fields in a smaller package.\n\nTAE Technologies is taking a different approach with a field-reversed configuration reactor that uses boron fuel instead of tritium — eliminating radioactive waste entirely. Helion Energy is pursuing a pulsed approach that directly generates electricity without a steam turbine.\n\nSkeptics point out that laboratory net energy gain is very different from commercial viability. They're right. But the gap is narrowing faster than anyone predicted, and the investment dollars suggest that smart money is betting on fusion within a decade.\n\nIf even one of these approaches works, it changes everything: unlimited clean energy, desalination at scale, and a realistic path to reversing climate change.",
    status: :published, featured: false,
    user: :carlos, category: :science, tags: %i[climate space],
    published_at: 1.month.ago,
  },
  {
    title: "How CRISPR Is Rewriting Medicine",
    excerpt: "Gene editing therapies are moving from laboratories to clinics, treating diseases once considered incurable.",
    body: "In December 2023, the FDA approved Casgevy — the first CRISPR-based gene therapy — for treating sickle cell disease. It wasn't just a milestone for biotechnology. It was the beginning of a new era in medicine where we don't just treat symptoms; we fix the underlying genetic code.\n\nThe numbers are staggering. Over 7,000 diseases are caused by single-gene mutations. Before CRISPR, most were untreatable. Now, clinical trials are underway for dozens of them, including cystic fibrosis, Huntington's disease, and certain forms of blindness.\n\nThe technology is conceptually simple: CRISPR uses a guide RNA to locate a specific DNA sequence, and the Cas9 protein cuts the DNA at that location. The cell's natural repair mechanisms then fix the break — either disabling a harmful gene or inserting a corrected version.\n\nBut the delivery challenge remains formidable. Getting CRISPR components into the right cells, in the right tissues, without off-target effects, is the engineering problem of the decade. Lipid nanoparticles, viral vectors, and novel delivery mechanisms are all being explored.\n\nThe ethical questions are equally complex. Somatic cell editing — modifying a patient's own cells — is widely accepted. Germline editing — changes that pass to future generations — remains controversial. The technology doesn't distinguish between therapy and enhancement, and society hasn't decided where to draw the line.\n\nWhat's clear is that CRISPR has moved from science fiction to clinical reality faster than anyone expected.",
    status: :published, featured: false,
    user: :ana, category: :science, tags: %i[ai machine-learning],
    published_at: 5.weeks.ago,
  },

  # --- PUBLISHED: Culture ---
  {
    title: "Why Everyone Is Reading Translated Fiction",
    excerpt: "The global fiction boom is dismantling the Anglo-American literary monopoly — and readers are better for it.",
    body: "Something remarkable is happening in publishing. Translated fiction, long relegated to a tiny niche of the English-language market, is experiencing unprecedented growth. Sales of translated novels have doubled in the past five years, and authors like Han Kang, Olga Tokarczuk, and Georgi Gospodinov have become genuine bestsellers.\n\nThe catalyst was simple: readers got bored. After decades of the same Anglo-American literary conventions — the Brooklyn novel, the campus novel, the autofiction memoir — readers wanted something genuinely different. They found it in Korean, Japanese, Latin American, and Eastern European fiction.\n\nThe internet accelerated the trend. BookTok's algorithm doesn't care about nationality, and when a Korean novel goes viral, millions of English-speaking readers discover it simultaneously. Publishers, who had been cautious about translation rights, are now aggressively acquiring them.\n\nBut the boom is about more than novelty. Translated fiction offers something that domestic literature increasingly lacks: genuine surprise. Different literary traditions have different assumptions about narrative structure, character development, and what fiction is for. A Japanese novel doesn't feel like an American novel set in Tokyo. It feels like a different way of seeing the world.\n\nThe implications for the publishing industry are significant. Translators, long the most undervalued professionals in the literary world, are finally getting credit and better compensation. Small presses that specialize in translation are thriving. And the definition of 'world literature' is expanding beyond the Western canon.",
    status: :published, featured: false,
    user: :maria, category: :culture, tags: [:productivity],
    published_at: 12.days.ago,
  },

  # --- PUBLISHED: Lifestyle ---
  {
    title: "Digital Minimalism Is Not About Using Less Technology",
    excerpt: "It's about using technology with intention. The distinction matters more than you think.",
    body: "Cal Newport coined the term 'digital minimalism' in 2019, and it's been widely misunderstood ever since. People assume it means deleting social media, buying a flip phone, and writing letters by hand. It doesn't.\n\nDigital minimalism is a philosophy of technology use where you focus your online time on activities that strongly support things you value, and happily miss out on everything else. The key word is 'value,' not 'abstinence.'\n\nThis distinction is crucial because technology isn't inherently good or bad — it's a tool. A carpenter doesn't minimize their use of hammers. They use the right hammer, for the right job, at the right time. Digital minimalism asks you to apply the same intentionality to your digital tools.\n\nIn practice, this means regularly auditing your technology use. Not 'do I use this app?' but 'does this app serve a value I care about, and is it the best way to serve that value?' A news app might keep you informed, but is scrolling headlines really the best way to understand the world? A messaging app connects you with friends, but does it do so in a way that strengthens or weakens those relationships?\n\nThe most powerful change I made wasn't deleting an app — it was moving my phone charger to another room. One physical change eliminated hours of mindless scrolling that no amount of willpower could prevent.\n\nDigital minimalism isn't a retreat from modernity. It's an insistence on using modernity on your own terms.",
    status: :published, featured: false,
    user: :ana, category: :lifestyle, tags: [:productivity],
    published_at: 4.days.ago,
  },
  {
    title: "The Case for Walking Meetings",
    excerpt: "Moving your body while discussing ideas produces better outcomes than sitting in a conference room.",
    body: "Steve Jobs famously preferred walking meetings. So did Aristotle, who taught while walking the grounds of the Lyceum. Modern research suggests they were onto something: walking improves creative thinking by up to 60%, according to a Stanford study.\n\nThe mechanism is straightforward. Walking increases blood flow to the brain, which enhances cognitive function. But the benefits go beyond physiology. Walking meetings remove the social dynamics of a conference room — there's no head of the table, no power position, no laptop to hide behind.\n\nThe format naturally constrains meeting length. You agree to walk a specific route, and the meeting ends when the walk does. No one extends a walking meeting by 30 minutes. The physical act of walking also makes silence comfortable in a way that sitting across from someone doesn't.\n\nWalking meetings work best for one-on-ones and small group discussions. They're ideal for brainstorming, giving feedback, and making decisions. They're less suitable for anything requiring a screen, detailed documents, or more than four people.\n\nThe practical tips are simple: pick a quiet route with good sidewalks, keep the group small, assign someone to take notes immediately after, and don't schedule walking meetings back-to-back with sitting meetings (the context switch is jarring).\n\nI've been doing walking meetings for two years. My one-on-ones are more honest, my brainstorms more creative, and my afternoons more energized. Try it for a week.",
    status: :published, featured: false,
    user: :carlos, category: :lifestyle, tags: %i[productivity remote-work],
    published_at: 2.weeks.ago,
  },

  # --- DRAFT: Articles in progress ---
  {
    title: "SQLite in Production: Lessons from the Trenches",
    excerpt: "We ran SQLite in production for 18 months. Here's what we learned about when it works and when it doesn't.",
    body: "The conventional wisdom is clear: SQLite is for development, PostgreSQL is for production. But a growing number of companies are challenging this assumption, and the results are illuminating.\n\nOur application serves 50,000 monthly active users, handles 200 requests per second at peak, and stores 15GB of data. We've been running SQLite in production on a single Hetzner server for 18 months. This article shares everything we've learned.\n\n[DRAFT - Sections to complete: WAL mode configuration, backup strategy, Litestream replication, concurrency limitations, when to migrate to Postgres]",
    status: :draft, featured: false,
    user: :carlos, category: :technology, tags: %i[rails devtools],
    published_at: nil,
  },
  {
    title: "A Designer's Guide to Accessibility Audits",
    excerpt: "How to audit your own designs for WCAG compliance without waiting for an accessibility specialist.",
    body: "Accessibility isn't a feature you bolt on at the end. It's a design constraint you consider from the beginning. Yet most designers treat it as someone else's job — something QA catches, or an accessibility consultant reviews.\n\n[DRAFT - Sections to complete: Color contrast checklist, keyboard navigation patterns, screen reader testing, ARIA roles for common components, automated vs manual testing]",
    status: :draft, featured: false,
    user: :maria, category: :design, tags: %i[design-systems css],
    published_at: nil,
  },
  {
    title: "The Economics of Developer Conferences in 2025",
    excerpt: "Ticket prices are rising, attendance is shifting, and the value proposition is being questioned.",
    body: "A three-day developer conference now costs $2,000-3,000 when you factor in the ticket, travel, and accommodation. For individual developers paying out of pocket, that's a significant investment. Is it worth it?\n\n[DRAFT - Sections to complete: ROI analysis, networking vs content, virtual vs in-person comparison, regional conference alternatives]",
    status: :draft, featured: false,
    user: :ana, category: :business, tags: %i[startup remote-work],
    published_at: nil,
  },

  # --- ARCHIVED: Older content ---
  {
    title: "Getting Started with Hotwire: A Practical Introduction",
    excerpt: "Everything you need to know to start building with Turbo and Stimulus.",
    body: "Hotwire — short for HTML Over The Wire — is Basecamp's answer to the growing complexity of modern frontend development. Instead of sending JSON to the browser and rendering it with JavaScript, Hotwire sends HTML. The result is dramatically simpler code that still feels fast and interactive.\n\nThis article covers the three pillars of Hotwire: Turbo Drive (replaces full page loads), Turbo Frames (updates specific parts of the page), and Turbo Streams (broadcasts changes in real time). We'll build a complete task management application to demonstrate each concept.\n\nNote: This article was written for Hotwire 1.0 and some patterns have changed in Hotwire 2.0. An updated version is in progress.",
    status: :archived, featured: false,
    user: :ana, category: :technology, tags: %i[rails javascript],
    published_at: 5.months.ago,
  },
  {
    title: "Tailwind CSS: One Year Later",
    excerpt: "A retrospective on adopting utility-first CSS across our entire product.",
    body: "When we adopted Tailwind CSS a year ago, the team was skeptical. 'It's just inline styles,' they said. 'The HTML will be unreadable.' Twelve months later, here's the honest assessment.\n\nThe good: development speed increased dramatically. Designers could make changes directly in templates without touching CSS files. The production CSS bundle shrank from 450KB to 12KB. Consistency improved because everyone was using the same design tokens.\n\nThe bad: long class strings are genuinely hard to read. We mitigated this with component extraction, but some templates are still walls of utility classes. The learning curve was steeper than expected — memorizing the class names takes weeks.\n\nNote: This article references Tailwind CSS v3. For Tailwind v4, see our updated guide.",
    status: :archived, featured: false,
    user: :maria, category: :design, tags: %i[css design-systems],
    published_at: 4.months.ago,
  },
  {
    title: "Five Books That Changed How I Think About Software",
    excerpt: "Not programming books — thinking books that happen to make you a better developer.",
    body: "The best programming books I've read aren't about programming. They're about thinking clearly, designing systems, and understanding complexity. Here are five that fundamentally changed how I approach software development.\n\n1. 'Thinking in Systems' by Donella Meadows — Because software is systems, and most bugs are system design failures.\n2. 'The Design of Everyday Things' by Don Norman — Because every API is a user interface.\n3. 'An Elegant Puzzle' by Will Larson — Because eventually, the hardest problems are organizational.\n4. 'Seeing Like a State' by James C. Scott — Because abstraction has consequences.\n5. 'The Mythical Man-Month' by Fred Brooks — Because it's still right about everything.",
    status: :archived, featured: false,
    user: :carlos, category: :culture, tags: [:productivity],
    published_at: 6.months.ago,
  },

  # --- SOFT-DELETED: Removed content ---
  {
    title: "Controversial Take: Microservices Are a Scam",
    excerpt: "An opinion piece that generated too much heat and not enough light.",
    body: "This article argued that microservices are architecturally unjustified for 99% of applications. While the technical points were valid, the inflammatory tone generated more controversy than constructive discussion. Removed by editorial decision.",
    status: :published, featured: false,
    user: :carlos, category: :technology, tags: %i[rails devtools],
    published_at: 2.months.ago,
    deleted: true,
  },
  {
    title: "Review: A Product That No Longer Exists",
    excerpt: "The product was acquired and shut down shortly after this review was published.",
    body: "This review covered a project management tool that was acquired by a larger company and discontinued. The content is no longer relevant.",
    status: :published, featured: false,
    user: :maria, category: :technology, tags: [:devtools],
    published_at: 3.months.ago,
    deleted: true,
  },
]

articles = {}

articles_data.each do |data|
  tag_keys = data.delete(:tags) || []
  user_key = data.delete(:user)
  category_key = data.delete(:category)
  deleted = data.delete(:deleted)

  article = Article.unscoped.find_or_create_by!(title: data[:title]) do |a|
    a.body = data[:body]
    a.excerpt = data[:excerpt]
    a.status = data[:status]
    a.featured = data[:featured]
    a.published_at = data[:published_at]
    a.user = users[user_key]
    a.category = categories[category_key]
    a.deleted_at = deleted ? rand(1..60).days.ago : nil
  end

  tag_keys.each do |tag_key|
    tag = tags[tag_key]
    ArticleTag.find_or_create_by!(article: article, tag: tag) if tag
  end

  articles[data[:title]] = article
end

puts "  Created #{Article.unscoped.count} articles (#{Article.unscoped.where.not(deleted_at: nil).count} soft-deleted)"

# =============================================================================
# Comments — ~60 comments across published articles
# =============================================================================
commenters = [
  { name: "David Kim", email: "david.kim@example.com" },
  { name: "Sophie Chen", email: "sophie.chen@example.com" },
  { name: "Marcus Johnson", email: "marcus.j@example.com" },
  { name: "Elena Popova", email: "elena.p@example.com" },
  { name: "Raj Patel", email: "raj.patel@example.com" },
  { name: "Yuki Tanaka", email: "yuki.t@example.com" },
  { name: "Liam O'Brien", email: "liam.obrien@example.com" },
  { name: "Amara Okafor", email: "amara.o@example.com" },
  { name: "Felix Weber", email: "felix.w@example.com" },
  { name: "Isabella Santos", email: "isabella.s@example.com" },
]

comment_bodies = {
  positive: [
    "Excellent article. This mirrors exactly what I've been seeing in my own work. The section on trade-offs was particularly insightful.",
    "I've been saying this for years but never articulated it this well. Sharing with my entire team.",
    "This is the most balanced take I've read on this topic. Thank you for not resorting to hyperbole.",
    "Bookmarked. The practical examples are what set this apart from other articles on the same subject.",
    "Really well-researched piece. The data points add credibility that most opinion articles lack.",
    "This changed my mind about something I've held strong opinions on for years. That's rare.",
    "Exactly the perspective I needed right now. We're going through this exact transition at my company.",
    "The writing quality here is exceptional. Clear, concise, and persuasive without being preachy.",
    "Finally, someone who gets it. The nuance in this piece is refreshing.",
    "I sent this to my CTO and we're reconsidering our approach based on your recommendations.",
  ],
  constructive: [
    "Interesting perspective, but I think you're underestimating the complexity of migration. At scale, the story is different.",
    "Good article overall, but the comparison in section 3 feels a bit unfair. The newer tool wasn't designed for that use case.",
    "I agree with the conclusion but not the reasoning. The performance benefits alone justify the approach, regardless of developer experience.",
    "Worth noting that this advice applies primarily to greenfield projects. Legacy codebases have very different constraints.",
    "The examples are solid but they're all from small teams. I'd love to see how this plays out at organizations with 100+ developers.",
    "Have you considered the security implications? Your approach simplifies development but may introduce attack surface.",
    "Strong disagree on point #4. In my experience, the overhead pays for itself within 6 months.",
    "I'd add a caveat about regulated industries. Some of these shortcuts aren't available when you need audit trails.",
  ],
  questions: [
    "Great writeup! How does this approach handle concurrent users? We've been hitting race conditions at scale.",
    "Can you elaborate on the deployment strategy? We're using Kubernetes and I'm not sure how to translate your setup.",
    "What about testing? Your workflow seems to skip integration tests in favor of unit tests. Is that intentional?",
    "Love this approach. Any recommendations for monitoring and observability once you're running in production?",
    "How do you handle database migrations with zero downtime? That's been our biggest blocker.",
  ],
  spam: [
    "Great article! Check out my blog at totally-real-website.com for more tips on making $5000/day from home!",
    "I agree! Also, I found this amazing tool that will 10x your productivity. Click here to learn more.",
  ],
}

published_articles = Article.published.to_a

published_articles.each do |article|
  # Each published article gets 2-6 comments
  num_comments = rand(2..6)

  num_comments.times do |i|
    commenter = commenters.sample
    days_after_publish = rand(0..14)
    commented_at = (article.published_at || article.created_at) + days_after_publish.days

    # Determine comment type and status
    if i < num_comments - 1
      # Most comments are approved positive or constructive
      body_pool = rand < 0.6 ? comment_bodies[:positive] : comment_bodies[:constructive]
      status = :approved
    elsif rand < 0.3
      # Some pending questions
      body_pool = comment_bodies[:questions]
      status = :pending
    elsif rand < 0.15
      # Occasional spam (rejected)
      body_pool = comment_bodies[:spam]
      status = :rejected
    else
      body_pool = comment_bodies[:positive]
      status = :pending
    end
    deleted = false

    Comment.unscoped.find_or_create_by!(
      article: article,
      author_email: commenter[:email],
      body: body_pool.sample,
      created_at: commented_at
    ) do |c|
      c.author_name = commenter[:name]
      c.status = status
      c.deleted_at = deleted ? rand(1..30).days.ago : nil
    end
  end
end

# Add a couple of soft-deleted comments
2.times do
  article = published_articles.sample
  commenter = commenters.sample
  Comment.unscoped.create!(
    article: article,
    author_name: commenter[:name],
    author_email: "deleted-#{commenter[:email]}",
    body: "This comment was removed for violating community guidelines.",
    status: :rejected,
    deleted_at: rand(1..30).days.ago
  )
end

puts "  Created #{Comment.unscoped.count} comments (#{Comment.unscoped.where.not(deleted_at: nil).count} soft-deleted)"

# =============================================================================
# Pages — 4 static pages
# =============================================================================
[
  {
    title: "About Meridian Magazine",
    slug: "about",
    status: :published,
    position: 1,
    body: "Meridian Magazine is an independent digital publication covering technology, design, science, business, and culture. We believe in thoughtful, well-researched journalism that respects our readers' intelligence.\n\nFounded in 2023, Meridian grew out of a simple observation: the tech media landscape was drowning in hot takes and engagement bait. We wanted to create a space for long-form articles that explore ideas deeply, present multiple perspectives, and leave readers better informed.\n\nOur editorial team is small by design. Every article is written by a subject-matter expert, reviewed by an editor, and fact-checked before publication. We don't chase pageviews. We don't optimize for social media shares. We write for people who want to understand, not just skim.\n\nMeridian is reader-supported. We don't run advertising, and we never will. Our independence is our most valuable asset, and we protect it fiercely.",
    rich_content: "<h2>Our Mission</h2><p>Meridian Magazine is an <strong>independent digital publication</strong> covering technology, design, science, business, and culture. We believe in thoughtful, well-researched journalism that respects our readers' intelligence.</p><h2>Our Story</h2><p>Founded in 2023, Meridian grew out of a simple observation: the tech media landscape was drowning in hot takes and engagement bait. We wanted to create a space for <em>long-form articles</em> that explore ideas deeply, present multiple perspectives, and leave readers better informed.</p><h2>Editorial Standards</h2><ul><li>Every article is written by a subject-matter expert</li><li>Reviewed by an editor and fact-checked before publication</li><li>We don't chase pageviews or optimize for social media shares</li><li>We write for people who want to <strong>understand</strong>, not just skim</li></ul><blockquote>Our independence is our most valuable asset, and we protect it fiercely.</blockquote><p>Meridian is reader-supported. We don't run advertising, and we never will.</p>",
  },
  {
    title: "Contact Us",
    slug: "contact",
    status: :published,
    position: 2,
    body: "We'd love to hear from you.\n\nFor editorial inquiries, pitches, and corrections:\neditorial@meridian-magazine.com\n\nFor partnership and sponsorship opportunities:\npartnerships@meridian-magazine.com\n\nFor technical issues with the website:\nsupport@meridian-magazine.com\n\nWe read every email and aim to respond within 48 hours. For corrections, we prioritize accuracy and will update articles as quickly as possible with a transparent correction notice.",
    rich_content: "<h2>Get in Touch</h2><p>We'd love to hear from you. Reach out through any of the channels below.</p><h3>Editorial</h3><p>For inquiries, pitches, and corrections: <strong>editorial@meridian-magazine.com</strong></p><h3>Partnerships</h3><p>For sponsorship opportunities: <strong>partnerships@meridian-magazine.com</strong></p><h3>Support</h3><p>For technical issues: <strong>support@meridian-magazine.com</strong></p><p><em>We read every email and aim to respond within 48 hours.</em></p>",
  },
  {
    title: "Privacy Policy",
    slug: "privacy-policy",
    status: :published,
    position: 3,
    body: "Last updated: January 1, 2025\n\nMeridian Magazine is committed to protecting your privacy. This policy explains what data we collect, how we use it, and your rights.\n\nData we collect:\n- Email address (if you subscribe to our newsletter)\n- Name (optional, if provided during subscription)\n- Basic analytics (page views, referral source — no personal tracking)\n\nHow we use your data:\n- To deliver newsletters you've subscribed to\n- To understand which articles resonate with our audience\n- To improve our editorial decisions\n\nWhat we don't do:\n- We never sell your data to third parties\n- We never share your email with advertisers\n- We don't use tracking cookies or fingerprinting\n- We don't build behavioral profiles\n\nYour rights:\n- Unsubscribe from newsletters at any time\n- Request deletion of all your data\n- Request a copy of all data we hold about you\n\nContact privacy@meridian-magazine.com with any questions.",
  },
  {
    title: "Editorial Guidelines",
    slug: "editorial-guidelines",
    status: :draft,
    position: 4,
    body: "These guidelines are for Meridian Magazine contributors and staff.\n\n[DRAFT - This page is being developed and will be published when complete.]\n\nTopics to cover:\n- Tone and voice standards\n- Fact-checking requirements\n- Source attribution policy\n- Conflict of interest disclosure\n- Correction and update procedures",
  },
].each do |attrs|
  rich_content = attrs.delete(:rich_content)

  page = Page.find_or_create_by!(slug: attrs[:slug]) do |p|
    p.title = attrs[:title]
    p.body = attrs[:body]
    p.status = attrs[:status]
    p.position = attrs[:position]
  end

  page.update!(content: rich_content) if rich_content && page.content.blank?
end

puts "  Created #{Page.count} pages"

# =============================================================================
# Subscribers — 20 newsletter subscribers
# =============================================================================
subscriber_data = [
  { email: "alex.rivera@gmail.com", name: "Alex Rivera", confirmed: true, confirmed_at: 5.months.ago },
  { email: "sarah.mitchell@outlook.com", name: "Sarah Mitchell", confirmed: true, confirmed_at: 4.months.ago },
  { email: "james.wright@yahoo.com", name: "James Wright", confirmed: true, confirmed_at: 4.months.ago },
  { email: "nina.patel@gmail.com", name: "Nina Patel", confirmed: true, confirmed_at: 3.months.ago },
  { email: "tom.anderson@proton.me", name: "Tom Anderson", confirmed: true, confirmed_at: 3.months.ago },
  { email: "lucia.moreno@gmail.com", name: "Lucia Moreno", confirmed: true, confirmed_at: 2.months.ago },
  { email: "kevin.zhao@outlook.com", name: "Kevin Zhao", confirmed: true, confirmed_at: 2.months.ago },
  { email: "emma.johansson@gmail.com", name: "Emma Johansson", confirmed: true, confirmed_at: 6.weeks.ago },
  { email: "omar.hassan@yahoo.com", name: "Omar Hassan", confirmed: true, confirmed_at: 1.month.ago },
  { email: "priya.sharma@gmail.com", name: "Priya Sharma", confirmed: true, confirmed_at: 3.weeks.ago },
  { email: "daniel.costa@proton.me", name: "Daniel Costa", confirmed: true, confirmed_at: 2.weeks.ago },
  { email: "yuki.sato@gmail.com", name: "Yuki Sato", confirmed: true, confirmed_at: 1.week.ago },
  { email: "marie.dubois@outlook.com", name: "Marie Dubois", confirmed: true, confirmed_at: 5.days.ago },
  { email: "chris.taylor@gmail.com", name: "Chris Taylor", confirmed: true, confirmed_at: 3.days.ago },
  { email: "ana.silva@gmail.com", name: "Ana Silva", confirmed: true, confirmed_at: 1.day.ago },
  # Unconfirmed subscribers
  { email: "new.reader1@gmail.com", name: "Jordan Lee", confirmed: false, confirmed_at: nil },
  { email: "new.reader2@outlook.com", name: "Casey Morgan", confirmed: false, confirmed_at: nil },
  { email: "new.reader3@yahoo.com", name: nil, confirmed: false, confirmed_at: nil },
  { email: "new.reader4@proton.me", name: "Riley Chen", confirmed: false, confirmed_at: nil },
  { email: "new.reader5@gmail.com", name: nil, confirmed: false, confirmed_at: nil },
]

subscriber_data.each do |attrs|
  Subscriber.find_or_create_by!(email: attrs[:email]) do |s|
    s.name = attrs[:name]
    s.confirmed = attrs[:confirmed]
    s.confirmed_at = attrs[:confirmed_at]
  end
end

puts "  Created #{Subscriber.count} subscribers (#{Subscriber.where(confirmed: false).count} unconfirmed)"

# =============================================================================
# Newsletters — 3 newsletters
# =============================================================================
[
  {
    subject: "Meridian Weekly: Rails Still Matters, and Fusion Gets Real",
    body: "Hello readers,\n\nThis week's highlights from Meridian Magazine:\n\n1. Why Ruby on Rails Still Matters in 2025 — Our most-read article this month explores why the framework continues to thrive.\n\n2. The Year Fusion Energy Got Serious — Private investment exceeds $6 billion as multiple companies demonstrate net energy gain.\n\n3. Design Systems Are Infrastructure, Not Decoration — Why treating your design system as a product changes everything.\n\nPlus: Digital minimalism, walking meetings, and the translated fiction boom.\n\nHappy reading,\nThe Meridian Team",
    status: :sent,
    sent_at: 1.week.ago,
    recipients_count: 15,
    sponsorship_amount: 250.00,
  },
  {
    subject: "Meridian Weekly: Local AI, Typography, and Solo Developers",
    body: "Hello readers,\n\nThis week from Meridian Magazine:\n\n1. The Rise of Local-First AI Models — Running LLMs on your laptop is becoming a serious development workflow.\n\n2. The Quiet Revolution in Web Typography — Variable fonts and fluid type scales are transforming how we read on the web.\n\n3. The Solo Developer Renaissance — One person can now build, deploy, and scale a profitable SaaS.\n\nWe also published our remote work analysis and a look at open source maintainership.\n\nEnjoy,\nThe Meridian Team",
    status: :sent,
    sent_at: 2.weeks.ago,
    recipients_count: 14,
    sponsorship_amount: 175.50,
  },
  {
    subject: "Meridian Weekly: Coming This Friday",
    body: "Hello readers,\n\nHere's what's coming this week:\n\n- SQLite in Production: Lessons from the Trenches (exclusive deep-dive)\n- A Designer's Guide to Accessibility Audits\n- Interview: The future of developer tooling\n\nStay tuned,\nThe Meridian Team",
    status: :scheduled,
    sent_at: nil,
    recipients_count: 0,
    sponsorship_amount: nil,
  },
].each do |attrs|
  Newsletter.find_or_create_by!(subject: attrs[:subject]) do |n|
    n.body = attrs[:body]
    n.status = attrs[:status]
    n.sent_at = attrs[:sent_at]
    n.recipients_count = attrs[:recipients_count]
    n.sponsorship_amount = attrs[:sponsorship_amount]
  end
end

puts "  Created #{Newsletter.count} newsletters"

# =============================================================================
# Site Settings — 10 configuration keys
# =============================================================================
[
  { key: "site_name", value: "Meridian Magazine", description: "The name displayed in the browser tab and header.",
    setting_type: :string, },
  { key: "tagline", value: "Thoughtful writing on technology, design, and culture",
    description: "Shown below the site name on the homepage.", setting_type: :string, },
  { key: "posts_per_page", value: "12", description: "Number of articles shown per page on the public site.",
    setting_type: :number, },
  { key: "maintenance_mode", value: "false", description: "When enabled, shows a maintenance page to all visitors.",
    setting_type: :boolean, },
  { key: "analytics_enabled", value: "true", description: "Enable privacy-respecting analytics (Plausible).",
    setting_type: :boolean, },
  { key: "newsletter_footer", value: "You're receiving this because you subscribed at meridian-magazine.com",
    description: "Footer text appended to all newsletters.", setting_type: :string, },
  { key: "max_comment_length", value: "2000", description: "Maximum character length for reader comments.",
    setting_type: :number, },
  { key: "require_comment_approval", value: "true",
    description: "If true, all comments require editor approval before publishing.", setting_type: :boolean, },
  { key: "social_twitter", value: "@meridianmag", description: "Twitter/X handle shown in social links.", setting_type: :string },
  { key: "social_github", value: "meridian-magazine", description: "GitHub organization name shown in social links.",
    setting_type: :string, },
].each do |attrs|
  SiteSetting.find_or_create_by!(key: attrs[:key]) do |s|
    s.value = attrs[:value]
    s.description = attrs[:description]
    s.setting_type = attrs[:setting_type]
  end
end

puts "  Created #{SiteSetting.count} site settings"

puts "\nSeeding complete!"
puts "  #{User.count} users"
puts "  #{Category.count} categories"
puts "  #{Tag.count} tags"
puts "  #{Article.unscoped.count} articles"
puts "  #{Comment.unscoped.count} comments"
puts "  #{Page.count} pages"
puts "  #{Subscriber.count} subscribers"
puts "  #{Newsletter.count} newsletters"
puts "  #{SiteSetting.count} site settings"
puts "\nVisit /login to get started. Try all three roles!"
