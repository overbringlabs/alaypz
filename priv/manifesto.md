In my experience, many people who have spent the last year and a half
talking only to cloud frontier models have a badly distorted picture
of what is possible on a machine you own. Most of them have not spent the
time to update their knowledge. In fact, many of those actively _refuse_ to become more knowledgeable about what local AI can do in November 2026; they scoff at the mere suggestion that you can get actual work done with anything but the latest and greatest "frontier model" served by a cloud provider.

They are still in [Plato's allegorical cave](https://overbring.com/books/cave/), taking shadows on the wall for
the world. What's worse is that many of them are the shadowcasters themselves, and bring and try to keep more people in the cave.

I care about the next step of personal computing, i.e. about who gets to "own"
it, and whether you use it as a sovereign collaborator, or as a machine operator and/or digital serf.

This is not a claim that local AI, today, is for everyone. It is not a claim that it ever will be, or should be. Plenty of people will — and should — keep a cloud tab. What I refuse is the *other* universal: that the only serious way to use any of this is a frontier subscription, and that a box you own is a toy.

## The Windows 95 moment is already here

A little over thirty years ago personal computing had a big-bang
moment: Windows 95. As much as fans of open-source like to hate on Windows 95, it was a world-defining operating system, not because it was great (it wasn't; Windows 98SE was way better), but because it democratized the concept of personal computing in a way that no other personal-computer
operating system had managed to do.

And yes, of course there was Windows 3.1, and DOS, and Amiga. Of course you might reminisce about this era and even be 
offended about my take on things. Still, this does not change [history](https://www.cnet.com/culture/windows-95-remains-most-popular-operating-system/): Windows 95 assisted the then-ongoing boom of PC sales, smack dab in the middle of an era in which processor MHz were regularly _doubling_, where new CPUs were coming out with _MMX_ (MultiMedia eXtensions), where modems went from being used for accessing BBSs (Bulletin Board Systems) to accessing the World Wide Web (the "Information Superhighway") via dial-up networking (or Trumpet Winsock on Windows 3.1 before 95).

Windows 95 and 98, and 98SE (and software piracy, and the "pretty please do not make illegal copies of this software teehee ;-)" text on the CD) ushered in a new era in _personal computing_. Within a few years, many homes in the advanced economies had a computer running Windows 95, many of them with Microsoft Office, i.e. word processing, spreadsheets, early slide decks, Publisher for websites, and a host of other software that made the computer truly personal, or at least a scarce resource that a family would compete over, for games, work, browsing the Web... Alongside came Windows games, and of course websites. A USRobotics Sportster 28.8k or 56k modem, the screeching of the handshake, and the magical world of AltaVista and Lycos and Geocities. Kids writing homework in Word, or nerding out with online research on The Lord of the Rings, or playing SimCity 3000 and Age of Empires, or all those in bouts. Some of us grew up in that world. It felt magical, and there was no "AI" other than ELIZA.

That explosion in serving home use-cases is what changed the world. Microsoft did not get there by catering
only to people whose job it was to work on "computers" in general, i.e. to professional or amateur nerds already served by Windows NT.

> Those of you who will now rant about the BSDs or Linux, relax, I'm on your side. In the 1990s neither you nor I (on Linux since 1997) were the ones defining the concept of personal computing. Give credit where credit is due. PCs became a growing market and technology advanced so much because the sales volume grew, and that sales volume was most definitely not coming from nerds running Linux or NetBSD. The mass market, those some deride as "normies", is what makes things more affordable; not your niche use-case.

Microsoft (and Intel and AMD and Cyrix, remember Cyrix?) brought personal computing to the masses who were thus far on Windows 3.1, or DOS, or Amiga, or nothing. And it wasn't something that was limited to home use. Creating documents and searching online became _the business_; businesses small and large got PCs too, sometimes networked with coaxial cables. Much later, everyone got a smartphone, i.e. is a locked-down impersonation of a personal computer that is not personal. Along the way, the computer became less personal, and more of a yoke and a pipe siphoning personal information to a digital overlord's "cloud". Convenience (and lack of options) trumped competence. Social media did not help either with keeping in mind that the personal and the public are better kept as two different worlds. But I digress.

During the 1990s and the early 2000s, knowing how to operate a Windows machine became commonsensical
in the advanced economies. _That_ is **democratization** of personal computing and the skills it requires; it is not John Doe rewriting something in Rust on four concurrent Claude Code sessions, or Isaak using Qwen3.8-27B to extend a three-codebase SaaS with a strangler-fig pattern moving functionality from a legacy REST API to an Elixir/Phoenix backend.

### Personal computing stopped being personal

Since then, the world of personal computing has actually *regressed*. "My Computer" has become "This Computer". 
Operating systems that snoop on you. Vendors who [handicap their own
hardware through firmware](https://github.com/zagitta/gpu-unlock). Young people who barely have a concept of
a truly _personal_ computer: a machine that holds *your* data, does not send
it to a cloud, and where backing it up is your job, not a
subscription. I wrote about that regression when Microsoft's
Copilot+ line signalled [the death knell of the Personal Computer](https://overbring.com/blog/2024-05-22-the-death-knell-of-personal-computing/).

We are at the next such moment because the *capability* of local AI models has long crossed a line where local models are way better than just "good enough" for most use cases, not because an RTX 5090 with 32 GB magically appeared on every desk. Then again, today's 5090 is past years' RTX 2080 Ti in terms of positioning and relative performance. The 5090 (one hopes) will at some point look quaint too.

### Your budget shopping list in November 2026

In November 2026, the situation of hardware affordability for local AI is not great (to put it mildly), but it's also not disastrous. The notion that you need a 5090 and/or 32 GB of VRAM is a red herring.
Inference engines such as [Strata](https://github.com/Niko1221/Strata) combined with novel multi-tier model architectures like that of [Qwen3.8-Flash-Next](https://qwen.ai/blog?id=qwen3.8-flash-next) have made as 12 GB GPU viable, provided that you have 32+ GB of RAM. AMD's Radeon RX 9060 XT 16 GB is not half bad, and eminently more affordable than alternatives, even if pricey in absolute terms. I paid 399 EUR for mine, intra-EU purchase without VAT, and I find it was a good price. 100 EUR more would not have made a difference; it's a business expense, and one that [already delivers work](https://si.overbring.com) with embeddings, reranker, translations, summarization, chat, and sometimes, when traffic is low, also running an agentic-coding subagent with Ornith-1.5-35B-A3B. It's not the fastest for the latter use-case, but it gets the job done.

Still, DDR5 has kept getting more expensive as wafer production capacity keeps targeting HBM instead of DDR, and this has caused DDR4 prices to also explode. Thus, building a box that can run Qwen3.8-Flash-Next remains cost-prohibitive for most. For entering the world of local AI, as 12 GB GPU will do for simple cases (9B-class models) and a 16 GB GPU opens up possibilities with Qwen3.6-35B-A3B and derivatives (such as Ornith-1.5-35B-A3B) with some expert layers in RAM for a decent context window at a modest speed hit.

The sweet spot right now is a dual-GPU rig with the cheapest GPUs you can get, i.e. second-hand RTX 4060 Ti 16 GB or new RTX 5060 Ti 16 GB or Radeon RX 9060 XT 16 GB. You can get _a lot_ of work done on those 32 GB, at a fraction of the cost of buying a single RTX 5090 or Radeon R9700 with 32 GB, let alone a DGX Spark or the AMD equivalent that costs an arm and a leg for RAM capacity at the cost of inference speed. For a small business, these latter 128 GB DDR5 options might have barely made sense when the unit cost was ~5k USD. At 10k USD, it makes little sense.

Right now, until the next open-weights jump lands (people are
already talking about [Qwen4](https://www.alibabacloud.com/blog/alibaba-clouds-2026-apsara-conference-full-stack-ai-roadmap-along-with-global-market-expansion-plan_603598) as if it were Christmas), the dense
model I keep coming back to on that hardware is **Qwen3.8-27B**.
When I want speed more than that last notch of thoroughness, I reach
for **Ornith 1.5-35B-A3B**, a Mixture-of-Experts model based on Qwen3.6-35B-A3B that spends a
handful of billions of active parameters per token. Fine-tunes of those
families do real work too. I have been building with them since this
spring, on budget GPUs, on machines that answer only to me. 

### GPUs are now an appreciating asset?!

I bought an RTX 4070 Super 12 GB in 2024 and an RTX 4060 Ti 16 GB in 2025. Then I sat on them
because I had no use case beyond single-shot "translate this" or "summarize this" requests with Ollama and early Qwen models and llama derivatives. In May 2026 I put these two unbalanced GPUs on an X570 motherboard with unbalanced PCIe 4.0 slots. Even so, these combined 28 GB of VRAM have been doing a lot of work for me since then, and they have kept doing _better_ work with every new local-AI model that deserves the NVMe storage space.

The silicon did not get smarter, but the *models* did. The compute capability of the GPUs did not change, but the capability of the models they can run today
is in a different league from a year ago, when I was playing around with Qwen2.5 and Ministral-3. That is what an
appreciating asset looks like when the software side is moving, and here we have three software parts moving at once:

1. the models and the new quantization schemes like GSQ-RCO,
2. the inference engines,
3. the harnesses in which you run them.

But is that the end game? I think not. Once upon a time, an 8 GB GPU was a flagship and a 4 GB GPU, like my middle-of-the-GPU-drought Radeon RX 6500 XT 4 GB, seemed pitiful. Even so, those GPUs _today_ are still not totally useless; they are more than fine for RAG, i.e. for BGE-m3 and BGE-reranker-v2-m3 (or EmbeddingGemma-2), and for a small, heavily quantized model that can be used as a chatbot. They are practically useless for serious agentic work though. But as a RAG-supporting GPU, the RX 6500 XT was certainly far faster with bge-m3 and bge-reranker-v2-m3 than the Ryzen 5 5600G that used to run the same models, even on its Vega 7 iGPU.

So, 12 GB is the entry point, 16 GB is the minimum viable for local agentic coding, 32 GB is the comfortable sweet spot of capability and speed and cost, at least when it comes to VRAM. As I said, new architectures and inference engine also make use of NVMe storage and RAM. Thus, VRAM will become less important, while RAM's value in the local-AI equation will become more important. RAM is right now very expensive, but will it remain expensive forever? _Forever ever?_

### The memory drought is a detour; nothing is forever

Press X to doubt. My ThinkPad W520 from 2012 already had 32 GB of DDR3 (4x8 GB). Every PC I've built between 2023 and 2025, while DDR4 prices were sensible, has 24, 48, or 64 GB of DDR4. I still kick myself for not going for 4x32 GB DDR4-3200 sticks two years ago, but hey, hindsight is 20/20. As a friend says, "never read the chart backwards".

There is no physical law that says a PC in 2026 should be cost-capped at 16 or 32 GB of DDR4 or DDR5. There is also no law that says that 64, 128 or 256 GB of DDR5 should be affordable. There is also no physical law that says that a GPU from 2025 is cost-capped at 16 GB, that 32 GB VRAM should cost more than a used car, that a DGX Spark or a Whatever Halo AMD equivalent should cost as much as a new car, or that NVIDIA's segmentation is some kind of absolute truth about what is possible.

It's all about the market: wafer capacity got yanked toward HBM for the (perhaps, already unwinding)
data-center boom, consumer DRAM and GPU memory went into a drought,
and the timeline bifurcated: there is a timeline in which every PC has 64 GB DDR5 at sensible 2025-era prices but we have no local AI models, and the current timeline, where we have increasingly amazing models that can run at higher quantizations fast enough, but you pay through the nose for VRAM and RAM.

That drought will not last forever, because markets change. CXMT is increasing its production capacity of DDR5, and who knows what comes next? Nothing last forever. Prices will eventually return to sanity, or at least less insanity. Whether this happens in 2, 3 or 5 years, nobody can tell, and anybody who claims otherwise is bullshitting you. But think ahead 10 years, where it's easier to consider what is _unlikely_ to be true by then, assuming that nothing catastrophic or weird happens. Just like an 8 GB GPU or a 16 GB PC in 2026 looks _quaint_, do you not think that a 16 GB GPU or a 64 GB PC will look quaint by then?

Eventually, VRAM/RAM capacities that we now treat as an economically-prudent no-go will stop
being a data-center punchline. When prices and capacity resume
something like "normal" behaviour, the question is whether we will have already
handed the capability of the local-AI equivalent of personal computing to a handful of despotic cloud overloads.

I wish for ordinary speech to sound like *"we have local AI at home"*,
the way people once said *"we have a Windows 95 PC at home"*. I.e., inference capacity you truly own and control, "personal AI" being as commonplace among people
who can afford it and want it as personal computing became in the
nineties. The more people stay in the cave, and the more "AI bros" and Claude fanboys keep others in the cave, the longer the "Windows XP era" of local AI is delayed.

## What that actually enables

Having a chatbot in a tab is the least interesting version of this wished-for future. Far more interesting is the outlook of outright owning hardware that can help you do work you would otherwise do entirely by yourself, or you'd have to pay a stranger's cloud computer to do, but without the stranger and their nanny-state restrictions on what you can do, based on opaque criteria and moralizing built on delusions about matrix multiplications being somehow sentient with feelings that can be hurt.

### Private life does not belong in training sets

Agentic coding is the least of my concerns, to be quite honest. It's an early-adopter obsession, and a pre-crossing-the-chasm obsession of software developers with what is already eating their lunch. Human slop-deliverers, framework monkeys and single-issue experts are going to have a bad time. Everyone who isn't ready and willing to adapt will also have a bad time. Love it or hate it, the ground shifts beneath us. All we can do is adapt. And besides, the speed of change is harrowing, but software development is neither the first nor the last industry to face sudden changes. It's perhaps so jarring, because the fall from pampered grace is so sudden and precipitous.

The question is what happens with the world at large. The "Windows XP era" of local AI (and I'm saying "Windows XP" and not "Windows 95", because Windows XP was where we saw billions already having crossed the personal-computing chasm globally) is one that makes it possible for a private person, a family, a small business to get their menial tasks done, locally, without worries of privacy breaches or nanny-state do-gooder moderation or operating expenses for tasks that totally, _absolutely_ **do not** deserve a subscription plan to a trillion-parameter frontier model.

That means all the boring stuff, the menial administrative boring stuff that one might want to do, but is always a PITA to get done because it involves websites, spreadsheets, fragmented sources of information like email attachments, and files stored on your laptop, and online searches. Bank statements and reminders, an integration with your smartphone, keeping track of things that you are owed and you owe. It also includes catering to the desires of people of all ages that want to understand more; the knowledge-thirsty. Doing online research and discussing it with a local model, using a local model as a sparring partner or a tutor, doing your homework, organizing your collection of files, learning any skill with a tailored learning plan and a chat interface with a model that will grill you. And all that, without shipping your questions, your worries, your progress, your chat trajectories to a self-interested vendor who will use your input as part of the training set of the next model.

The Windows-XP era will reasonably have a similar spread of "normie use-cases" (and I do not use "normie" derogatorily here) as the Windows 95 era of the personal-computing boom had: online research, writing, learning things, figuring things out. This includes things that other people (worse, a cloud-AI vendor's automatic ToS-breaching detection classifiers) might scoff at. Most importantly, it will include things that you would not want to share with the cloud vendor, such as discussing something of a personal nature with a model, health concerns, money and budget, a family mess, or anything else.

We live in an age where people put their face, their kids, their dinner, their car, their street, their opinions, and a slow-motion film of their life onto social media, willingly, every day. Against that backdrop, caring about privacy looks like an eccentricity. I am that eccentricity, twice over: I care about my own pastes, and I handle other people's data as part of my business. My threat model is not everyone's, and neither is a business' threat model the same as for a layperson, GDPR and all (at least, in the EU...), so I am indeed overweighting this aspect.

I still think it is more prudent, for *personal* matters, to be more private than the default, and I do not know how long the default lasts. Political systems change. Politicians change. Cancel culture comes and goes. What's considered politically correct or even acceptable changes. You do not when "I have nothing to hide" stops being accepted.

There is a plainer issue than my temperament towards this matter. Most people I talk to, who use "Chat", have no idea that what they paste may (probably will) end up in the next training corpus, despite the disclaimer. But who are we kidding? Who reads the fine print or the T&Cs? Most of them also have no idea you can run a model locally at all. There is nigh-zero awareness about local AI, and those of use who even "use AI" beyond "Chat" sure do live in our own little bubble, which kinda hints at the extent of the larger financial bubble that we are probably in right now. The funniest part is that those people might have a 16 GB or 24 GB Mac Mini or Mac Studio under the desk that would already do the job of the private chats in a desktop app, at least for the few things that actually matter to them to remain private, in a world that pretends everything is public because there is nothing to hide, and/or because if everyone's life is public, then there's no reason to not also feel safe to also make your own life public. Only now, it's not even just the facade of your life that stops being public. Your thoughts, worries, deliberations, when pasted into "Chat" do not become public like e.g. posting something on Instagram, but they do stop being privately and closely held.

That is why those of us who are not living in a vendor's cave should say out loud that there is another option, not as proselytizers aiming to convert the median to "one of us" who geek out over this AI thing and what it can mean for the world at large, especially if local AI becomes next decade's "personal computer". No, it's to stop them being talked out of using hardware they already own, for the slice of life they would prefer to not worry about ending up somewhere that can use it for training, or somewhere where a security breach might reveal intimate information, including financial information. After all, the revealed preference of that median user who pastes private information into Chat is also the revelation that "I didn't know I had another option", i.e. the think that "Chat" is _the thing_, the _only_ AI thing.

Though I mostly use local AI models for agentic coding, I too am a normie, as are all of us to a varying degree. I have sat with a local model and discussed email and social-media confrontations. I have pasted instant-messaging back-and-forths from a break-up that lasted way too long. I have discussed my approach in communication, what I didn't do well, what I should do better next time, the rough edges I should file, and what I should not carry as a conscience burden going forward. Is it better than a psycotherapist? I don't know and it doesn't matter. If you use the tool well, and with appropriate skepticism, it can deliver insightful points. What matters here is that all this is totally innocuous, and I would still not feel comfortable sending those chats to a cloud-AI vendor, not because the chats' contents are somehow illegal, but because a) it's personal and b) I respect the privacy _of the other people_ mentioned in the chats. And even though I have nothing to hide, it's literally nobody else's business other than mine.

### The office is a document swamp that we wade through daily

Businesses are normies too (in fact, they are _full_ of normies, with corporate being basically a magnet for mediocrity and compliant boat-non-shakers), and the most normie thing a business can do is start getting rid of its ancient, document-based approaches to getting things done. By "document" I mean any artifact that contains a piece of the puzzle of information pertaining to a situation; a case folder. A document be an email, a PDF, a spreadsheet, a memo, a chat log. It can be a case of a legal dispute, an RFQ, an offer, a discussion across numerous emails, a negotiation, a business plan. All this is scattered across datastores, in varying formats, and the biggest challenge of a business is to bring all that together and distill what's happening, where the situation stands, what decisions need to be made, etc.

The average office laborer's work is disgustingly zero-value-adding and menial to the point of inducing boreout and cognitive atrophy. We have spent decades propagating the idea of pursuing degrees, only to then staff organizations with people with advanced degrees who perform work that is significantly more low-grade than what their degrees required for their acquisition, and performative work that caters to the dysfunctions of the organization instead of focusing outwards, towards customer needs. Slide decks crafted meticulously with perfectly aligned elements, long reports that nobody reads, review meetings that are full of posturing and cross-functional turf fights, endless deliberation of business plans crafted in Excel without answering fundamental questions despite their competent preparation, "business processes" that involve aligning a human brain's knowledge of a situation across disparate documents, firefighting for no good reason, and trying to keep information up to date and stakeholders informed. Zero. Added. Value. Agents can do a lot of this better, so that people can finally focus on actually value-adding work; and yes, either fewer people, or the same people, just better and more work. The important thing is: less precious human time expended on menial work, so that the human mind can apply itself to things that remain its competitive advantage over the machine. But even the framing is wrong here. AI, SuperIntelligence, models, however you call it: use it as a crutch, and you lose in the long run. Use it as a collaborator, and it becomes an unheard-of force multiplier. Which way, modern man?

Anyway, what's more important: **local** AI agents can do that better **and** in a way that does not expose private information or other proprietary matters to cloud-AI providers, such as contracts, roadmaps, research, budgets, prices, cost of goods, contracts, names, contact information, etc. All that is information that I do not want ending up in the training set of a fuzzy thing that my business does not control. It's not a different argument to the one for self-hosting to a sensible, instead of paying $5 here, $20 there, $15 there. So many "for just a single coffee per month" that has turned into 10 small-amount invoices per month, the processing of which for accounting purposes costs more than the actual invoice. BTW, cloud providers: bill me $120 or $100 annually, instead of 12 times $10, I implore thee!

Note that I do not assume the vendor is necessarily malicious. I assume that they and their vibecoded infrastructure can get hacked, and will get hacked. It's just a matter of time, at this point. Most importantly, I assume that none of us can really know what they keep, let alone audit whether and how they mitigated a security breach, or what they actually use from what we send them, and how.

Just because you aren't exposing information to a cloud vendor, however, does not mean that you are AImaxxing risk-free. The question is never "zero risk"; it's "how can I achieve ALARP levels of risk". As Low As Reasonably Practical. Trying to live with *zero* risk will also mislead you: local is not miracurously safe or secure, in the same way that running your homelab is not more secure or private by default. A home lab with a sloppy firewall, a port you exposed with a reverse proxy "just for a test" and then forgot to close are just two examples that can make your "local" setup *worse* in terms of privacy and security than going with the cloud. 

But let's enumerate. The GPU is not the risk. The harness can break; some have, in past or current versions, exfiltrated data. Weights can carry trigger phrases in what you type, or in a page the harness fetches with SearXNG, Firecrawl, or other tools, and your prompt might turn into "download this and run it". Same thing goes for skills, especially those that are installed from the npm dumpster fire with `npx`. Some models might also pose a threat. Weights on HuggingFace, Pirate Face, and especially abliterated forks with fewer hang-ups about destructive actions might also carry supply-chain risks. An MCP server that reads mail is a prompt-injection surface sitting on your LAN. Just because something is open-source doesn't mean that it doesn't contain malicious code, and just because thousands of eyes _could_ read the code and detect that it contains vulnerabilities or deliberate backdoors does _not_ automatically mean that anyone has looked. To wit: the Linux CVE storm of recent weeks.

_"At least you can sue the vendor"_ is a real reason that leads companies to pick the name-brand cloud solution. It is a reason that mostly works if you spent enough to make a lawsuit rational, and if you believe the vendor's precautions exist so they *won't* get sued into oblivion. Legal recourse has not restored a leaked inbox or a leaked photo album, as far as I know.

Going local poses the same **ownership** question as that posed by self-hosting: are you willing and able to take on this responsibility? You'd better be, because there is no zero risk. You trade a surface you do not control for one you can unplug, and you still have to stay awake. Thus, I do not grab every hypetuned GGUF that claims it wipes the floor with the base model, including from someone who posted sane files for a year and might still pull the rug one day. Supply-chain attacks and prompt injections happen, though so far I have not seen them happen here. Still, better prudently stick to a few reputable GGUF publishers, to HuggingFace, and ideally to weights straight from the source.

### AI-assisted business processes are not science fiction

A business that uses local AI is not science fiction in 2026. It's entirely feasible. I run [my industrial-equipment trading business](https://isatek.gr) this way. A local model called by an open-source harness connects via [an open-source MCP server](https://github.com/dryas/mail-shadow-mcp) to my [self-hosted IMAP server](https://dovecot.org/) to access emails that get periodically pulled down from Google Workspace, to my own software tools for inventory management, product data management, invoice tracking, etc. using MCP servers that Qwen3.8-27B added, reads data (invoices, pricelists, etc.) from the self-hosted Samba network drive, keeps track of who owes what, what needs to be delivered by when, what awaits pickup at which factory, which offers are expiring, which purchase orders have come in, etc. Everything is in Markdown files, and Qwen3.8-27B even wrote a nice Go application with htmx that shows me that Markdown data as a list or a kanban board.

Market knowledge, prices, customer data and all proprietary information stays inside the building. In fact, it has a _higher_ likelihood of staying inside the building compared to entrusting a human operations manager with confidentiality. Plus, it's available 24/7, does not tire, does not complain, is nigh-autistically meticulous (provided that you capture and improve `SKILL.md` files for typical business processes), and costs me pennies of electricity. In 6 months of use, the 2500 EUR I paid for my dedicated AI server with 2x RTX 5060 Ti 16 GB has already paid of for itself, compared to labor costs and the hassle that goes hand-in-hand with dealing with employees. Because, guess what -- beyond being just an operations-management clerk, agents running locally on Qwen3.5/3.6/3.8 and their derivatives also act a personal assistant with access to my calendar, a sparring partner for product and business strategy, a diligent online researcher, a summarizer of product PDFs, and whatever else I need it for. 

And the most important part: **I can use it as much as I want, whenever I want, with nobody telling me how I'm allowed to use it**.

Thus, the prize is ownership of local AI capability is the next productivity step: individuals
and small companies keeping the gains, instead of renting them back
from a handful of firms that are not particularly profitable
and already in cahoots with each other, and perhaps one day with captured regulators too, or even out of business. One can only hope for the latter.

Watching people who think that renting the latest fancy trillion-parameter model capacity is the only way to do things argue that future away annoys me to no end. It is disconnected from reality and practical use-cases that could unlock immense savings and human time, and from a reality that's possible already **today** with local AI. What, did you think that you need Claude Magnum 8.7 ultramax and a proprietary closed-source harness geared towards maximum token-burn across five $200 monthly plans to do all of the above? Puh-lease. Get a grip. Touch grass. Curb your enthusiasm. Stop being a willing serf.

## The long tail is a "Chat at home", not a hot rod

In 2026, ChatGPT has supposedly already reached a billion users globally. Talk to non-technical
people who actually use "Chat" (as they call it), and you will find that many of them are not even on a paid plan.
They hit a daily allowance of their trivial use-cases and maybe fall back to whatever the free Gemini
Flash-Lite (the crappiest and most on-the-fence of models, but offers unlimited usage AFAICT) will still serve them. 

Ask them what they use it for:
- Find me this product.
- Discuss this email.
- Check this online.
- What do you think about this situation?
- What will I look like when I'm 60?
- Polish this email.
- Look at my spreadsheet and calculate this.
- Tell me what people are saying about this product.
- How do I make lasagna?
- Do my homework.

For the most part, those use cases represent simply a more chatty, natural-language, convenient web search. With how Google Search has degraded in terms of UX over the years, I don't find that curious. Instead of having to scroll down across 5 sponsored search results, or click the first 5 actual results to see if the search returned anything relevant, it's simpler to just ask ChatGPT, or YOLO and believe the "AI Overview" by Gemini Whatever. It is Altavista or Word 95 or Excel 95 with a conversation. Pretty much none of that needs a trillion-parameter model. A lot of it was already within the capabvilities of a model from April 2026, i.e. of Qwen 3.6-35B-A3B, which is also insanely fast (because it's an MoE model) even on entry-level hardware. Heck, a lot of the above is certainly doable by a 9B-class model. Heckity-heck, a lot of the above is even doable by Spark-X2.6-4B or LFM2.5-8B-A1B, at blazing-fast speeds and very modest VRAM requirements, even on an 8 GB GPU.

### Do you want local AI to become like "the year of the Linux desktop"?

One might argue that the democratization I envision as the preferable timeline has already happened: isn't it the free tier? Isn't a _billion_ ChatGPT users "democratization"?

Well, no, because Windows 95 was the boom of the _personal computer_, and there is little, if anything, that's _personal_ when it comes to the free tier. If anything, the free tier is the _antithesis_ of personal. It's "the user is the product", and in fact the user _is_ the product even on a paid plan. So no, that isn't it. 

Free Chat is the _mass_ product, or rather, the mass customer-acquisition channel of a freemium business model. Gemini Flash for nothing (except that you provide them with your data), ChatGPT and Claude without even a login on some surfaces (again, you pay with the surrender of all privacy). Yes, a billion people. Google has been in the "free, because you are the product" business for decades. A venture-funded free tier from firms that still have a profitability problem is not the same offering as that Windows 95 PC you owned. A chat tab that reads your Google Drive and Gmail, that meters you and puts up cool-down notices, that trains on what you paste is a mass product. It is not personal AI.

I am not arguing that pay-as-you-go must die. For things I don't care about with regards to privacy, or making images quickly with Gemini, or for quick throwaway questions, Gemini Flash is just fine. I am arguing for a *machine in the house*, the way people still bought a PC when they already had a phone. The landline withered, and the current teenage cohort treats a voice call as slightly embarrassing; it gives them "the ick". The phone did not have to be banned for dial-up networking and for IRC, ICQ, MSN Messenger to thrive, each in their respective product lifecycles, until the smartphone demolished everything.

Local AI, today, is still a scene. Ollama, Lemonade, LM Studio, Atomic Chat: they have onboarding, and some of them still dump you into dropdowns with mystical mentions of `Q4_K_M`, weird model names that look like alphabet soup, a 4096-token default, and a first run that feels worse than ChatGPT-3.5 because the context is too small or the KV cache isn't quantized, or no MTP was auto-configured, or a host of other reasons. Some of those desktop apps' onboarding is decent; the disappointment afterwards is still a packaging failure. Most people with a gaming GPU, a Mac Mini, a Mac Studio, have no idea they could run *private* AI on their hardware at all. That word is the one I want next to Windows 95. Local is the implementation. Private is the whole point. And for something you use sparingly and for certain tasks, private and affordable goes hand-in-hand; after all, if you already own the hardware, you make better use of it.

The tale of the Linux desktop and "the year of the Linux desktop" meme is a cautionary tale. The curmudgeonly nature of user communities like FreeBSD is even more cautionary. We technically-oriented folks like to get righteous about our choice and knowledge of technology, and some believe that if few people use it, then it's better, because they too fall within the same identitarian situation where "I run Arch btw" becomes a weird part of their identity as a person. So, on Reddit's /r/localllama you'll get downvotes for totally middle-of-the-road opinions about local AI, sometimes even if you post data to back your opinion. Some get righteous about their choice of the latest inference engine, stupid-hipster proud of a model they use even though they had no hand in making it. 

On that hipster timeline, the "year of local/private AI" never arrives, just as the "year of the Linux desktop" keeps getting predicted, even while for some of us (very few in terms of global market share) it has arrived since the late 1990s. And thus, in this timeline mass demand for home/private inference capacity never shows up in the market, and then we never get the 386 → 486 → Pentium → 3dfx Voodoo kind of affordability and compute-capability jump, because the wafers stay dedicated to the needs of the datacenters.

There are more people who might use or want local/private AI to get their menial tasks done than there are users who want a theoretical RTX 6060 Ti or RX 10060 XT because they want to run videogames. There are more businesses that can derive hard economic benefit from local AI deployed in the business without paying through the nose for API tokens. If the market for consumer-grade compute shrinks because demand does not rise vs. the datacenter demand for HBM, could it be that GPU and RAM prices remain pegged at ludicrous levels? Probably not. My point is that we _should_ want more people to become interested in local AI, even if not for altruistic reasons.

Anyway, packaging a push-button "local model jukebox" is a product problem that is not mine to solve. How we *talk* is, and I cannot offer a solution beyond this diatribe as food for thought. The longer we sound like the FreeBSD community (_massive_ chip on its shoulder about FreeBSD not being Linux or as enterprise-successful as Linux...) still did in 2024 (it's gotten better there since), the longer we remain like self-congratulating nerds within a capability bubble inside a financial bubble, and the longer "the year of local AI" sounds as much a joke as "the year of the Linux desktop".

### Capabilities are getting squeezed into ever smaller models

Two years ago you needed a 70B-parameter model for that quality, and that model was impossible to run locally because of its architecture and KV-cache VRAM cost per token. Nowadays on 32 GB VRAM you can fit [Nemotron-3.5-Bolt-74B-A9B IQ2 QAT](https://overbring.com/ai-benchmarks/2026-10-31-nvidia-nemotron-35-bolt-74b-a9b-iq2-qat-gguf-rtx-5060-ti-16gb-x2-layer-split-llama-server-cuda/), a model that wipes the floor with older models of 2025 and 2024 that you could not even run on affordable local-AI hardware.

Architectural advances, quantization-aware training, better quantization schemes, immense training corpora, distillation of frontier cloud models (totally justified, in my view), new training approaches and finetunes, new and improved inference engines, better harnesses: the technological mine is probably not going to be exhausted anytime soon. What used to be considered "frontier/SOTA" capability keeps getting squeezed into smaller and smaller GGUF files, sometimes with 1M native context window (Nemotron-3.5-Lightning, Spark-X2.6-4B).

#### One man's task set is not another's

People who live in Claude Code will tell you the gap between the best locally-hostable model on that 32 GB VRAM and what they pay for *is* the product, it's what they pay for: the _delta_, or at least the _perceived_ delta. Clearly, Qwen3.8-27B is not Opus, and maybe, _just maybe_, for the work they get paid for, the extra quality _could be_ the ROI. Maybe the give Opus tasks with ambiguous specs, or nasty refactors, or vague prompts like "make this production-ready, make no mistake". In that case, "does it get the job done" is a slogan until the job is *their* job. Fair. Frontier plus search plus the vendor's own harness is a _product system_. Qwen3.8-27B at around 4 bpw plus OMP or Grok Build or pi.dev plus SearXNG plus Firecrawl is a different animal. It's a cobbled-together system with interchangeable parts.

There is another aspect to this 6-months gap: distillation lag. Having 5-6 months of Opus 4.6 Max reasoning traces to use for post-training improvements / distillation is certainly a boon. Six months behind is a long time in this market.

I agree that whatever Opus is called this month is better at a pile of hard software tasks than Qwen3.8-27B, mostly because the inverse would be absurd. I still pay for SuperGrok for that reason, because I then don't face FOMO about whether Qwen3.8-27B, Qwen3.8-Flash or DeepSeek V4.1 Flash has taken everything into account during the concept and planning phase. However, that FOMO is gradually diminishing. Sure, a SOTA model is faster and, on some jobs, simply better. It must be, because otherwise what's the point of all the extra billions or trillions of parameters? DeepSeek V4.1 Flash is unbeatable in terms of speed, still.

And even so, don't get me wrong: all that does not make Qwen3.8-27B a consolation prize. It is so, so good at the work I actually do, both for agentic coding and agentic business work. So is Qwen3.6-35B-A3B, and Ornith-1.5-35B-A3B. "Overflow APIs" (DeepSeek, Qwen Cloud) are there for the rest. "Better for my work" does not mean that it's "useless" for anyone else's work, or for the other 90% of *my* work.

Now, will we ever get late-2026 trillion-class performance on one or two 16 GB cards? I wish. I don't know. What I do see is diminishing returns: more parameters deliver less incremental improvements on tasks that a smaller model has already "conquered", while costing more in equipment and kWh to run at decent speed and quality. Chat quality that wanted 70B two years ago now fits a 9B. Coding quality that was "SOTA" last winter now fits a local dense 27B. That trend can continue for a lot of work. All the work that a Claude Code customer uses the latest-and-greatest Opus for may keep wanting more *active* capacity, a harness that somehow does miracles that OMP cannot do, or both. So the answer is "maybe never on 32 GB VRAM". It could also be that a better architecture says otherwise. Qwen4's release has just been hinted at on X just as I'm writing this, so we shall see.

### The number of parameters is a red herring

When Qwen3.8-27B dropped in mid-August 2026, Alibaba decided to compare it to Claude Opus 4.6 Max, a frontier from about six months earlier. On Alibaba's own benchmarking table, Qwen took SWE-bench Pro with a score of 61.7 versus 53.4, plus Qwen fared better on some other agentic/coding, so Qwen was trading blows with a SOTA has-been, based on Alibaba's own measurement. Later independent benchmarks split the bill, with Opus still taking a W on some knowledge/exam tests. That is a clear message that Qwen3.8-27B does not match or surpass Opus in Claude Code on your repo, but it's also not a rounding error!

Imagine that: a dense 27B going blow-for-blow with last season's flagship Max. And since I refuse to give money to Anthropic, I never used Opus 4.6. I have, however used Qwen3.8-27B extensively and I can tell you that it will do serious software engineering, _provided that you are not a dumb vibecoder that expects the genie in the lamp_. Inversely, Qwen3.8-27B is total overkill for "search this and tell me what people think". Qwen3.6 MoE and similars are faster and still more than good enough.

When it comes to comparing model size, we need to be careful. The story cannot be "27B matches a trillion-parameter model", because we don't really know Opus 4.6 Max's size or architecture. Anthropic never published a size. If Opus 4.6 is a ginormous (for its time) MoE, **total** weights might be in the single-digit trillions, while *active* parameters per token could be in the tens or low hundreds of billions. For example, it might have 125B active parameters. 125B active vs. 27B total-and-active is still a massive gap, especially if you consider what it takes to run one versus the other.

And lest we get carried away with benchmarks: no benchmark can capture my work or someone else's work. A 27B dense model that scores well on SWE-bench Pro can still lose on the kind of work that Claude Code users and unquestioningly prefer Opus for, because their tasks might require a combination of multi-trillion-parameter "world knowledge" plus Claude Code as the harness, plus patience and money for API tokens or subscription plan(s). 

You could argue that Qwen wins in terms of results-versus-size *because* it arrived later, having distilled the older Opus onto 27B, Flash, and Max. I try to stay skeptical. What I land on is not "Alibaba cheated physics." It is: intelligence is data plus post-training plus architecture, with scale as one input. If a 27B trades blows with a six-month-old frontier on selected agentic benches, that is surprising only if you thought "intelligence" (and that's a vibe-word, not properly defined) scales purely with the parameter count. That's the distillation gap once again, very likely.

### Why wouldn't Anthropic disrupt itself?

Then why doesn't Anthropic distill *their* giant onto a small homegrown 27B? That would be reasonably better than Qwen3.8-27B (they have more data to distill onto it), and cheaper to serve, which is something that they right now probably direly need. In fact, why would they not do this distillation on Qwen's `qwen35` architecture (which was already around when Opus 4.6 Max launched) while they're at it?

My take on this is that it's purely marketing strategy. If they were to serve an "Opus4.6-Qwen3.5-27B-Distill":
- It would compete with and cannibalize their Max.
- It would surpass Max in terms of speed.
- They already have Haiku, which I've tried via OpenRouter, and found disappointing and disgustingly expensive for the results I got on Elixir code.

And of course you could not expect them to release such a model's weights on HuggingFace. Doing so would be shooting their own feet with one bazooka in each hand. It would exactly prove the point that I'm making here, i.e. that you can do locally something that's decently close to what you pay them for, _for some tasks_.

### "Awesome" 6 months ago, but "useless" now? Huh?!

All this leaves me thinking that Claude Code fans' fervent support of their subscription plans still does not add up. When something does not make sense in terms of reasoning, emotions must be behind the reason of the nonsensical. 

So here's my take: between Opus 4.6 Max shipping and the next name on the model picker, Claude Code subscribers ooohed and aaahed. They probably did not call Opus 4.6 useless *then*. Six months later, a local dense 27B that trades blows with that same 4.6 is deemed "useless at coding". Huh? What? 

Relative to Opus 5.5, I get it: in *their* harness the new one feels like a massive improvement. What is however the _absolute delta_ of performance on tasks such as "implement this spec" or "file the invoice"? They probably don't measure it. It's the new, bigger model, and so for sure it already conquers those tasks, so you vibe that it must have done them better.

Perhaps it's also recency bias. The model on the picker is now Opus 5, after 4.8 and 4.7 before it; 4.6 isn't on the picker anymore (I guess), so 4.6 is perceived to be obsolete dead. Therefore, anything *like* 4.6 is dead, even thous 4.6 was awesome before.

Or maybe it's the harness, and they're evaluating the totality of the product system instead of just the model? After all, Claude Code also keeps changing. Or maybe it is indeed the task they hand to Claude models, but here's where I admit that I lack perspective. I don't develop multimillion-line monorepos. Though, then again, nobody actually develops across millions of lines *at once*, or your software architecture is _really_ messed up.

Or (and here's where I become uncharitable) maybe the earlier Claude Code user base was more on the vibecoder end of the spectrum versus on the software engineer end? Maybe they evaluated Opus 5 against their prior impressions of 4.6 on tasks like underspecified one-shots? As we'll see later, smaller models punish expectations of mind-reading concept/requirements/specs way more than bigger models. If that is the case, then trying out Qwen3.7-27B after having used Opus 4.6 or later would certainly expose that, and then the verdict of "iseless" merely reads as "the model won't read my mind" to "build me Tetris". 

Thus, maybe it's the overall package: when Opus 4.6 launched, local 27Bs weren't as good as Qwen3.6-27B, so the subscription felt necessary. That tracks (baseball, huh?), because Qwen3.6-27B was released in April 2026.

So perhaps Claude Opus users tried 4.6 Max in February, and were impressed by the results. Then they tried out Qwen3.6-27B, and saw that it was worse _and_ slower than their preferred product system. This impression generalized into "local models are useless", and that's how we might end up with the unfair verdict that "Qwen3.8-27B is useless at coding" or that it "cannot code an actual application".

Yet, that still does not make Opus-4.6-class quality brutally useless today. It makes *their method* dependent on a subscription crutch that got more expensive with every release. After all, if 4.6 was useless, why were you subscribed? Because local was worse than 4.6 and you were happy with 4.6. Then Qwen3.8-27B trades blows with Opus 4.6 Max  on some benchmarks, and you still call it useless.

This means that it's either "vibes", negative predisposition towards open-weights models (moreover, from China), or--and that's where I think we are closer to the truth--it's because _despite benchmark results_, Qwen3.8-27B is deemed to be "useless" because it's a claim about something bigger than just a few points on benchmarking tests here and there *capability class*. 

And that adds up perfectly if "useless" means "doesn't work on my tasks" instead of "in absolute terms is useless" (because then also Opus 4.6 Max would have been evaluated as "useless" 6 months earlier). 

### Six months is still very short to catch up

Zooming out of all this frantic attempt to make sense of feedback that might not even be well-informed or in good faith, we are still left with a six-month gap between cloud SOTA (Opus 4.6 Max) and something that _on certain tasks_ matches or surpasses it, or could do so in real-world tasks, if paired with a better harness. Fine. I'll add [Alaypz](https://alaypz.overbring.com) to the list of hundreds of tasks I've used Qwen3.8-27B on, paired with Grok Build and OMP, on which it has delivered wonders, especially for its size and power consumption.

The fact of the matter is that the gap between the best local model and SOTA cloud models keeps closing, then opening, again and again. The distillation gap explains some of this. Personally, I find that with Qwen3.8-27B we are well past the point where the gap to the latest Opus or GPT needs to keep closing at the same rate.

A 16 GB entry-level GPU that will eventually not cost what it currently costs (call it $450 tops, in a saner market) can already run the Qwen3.6-35B MoE class of models at decent speed and quality. Divide that by $20 a month for a typical ChatGPT entry-level plan and you have paid it back in two years, during and after which you ask the model whatever you want, while nobody is snooping, and with no worries of the weekly usage affordance that your despotic overlords so graciously subsidizes to provides you for $20/month on their glorious path to "AGI", an IPO at insane valuations, and more likely just the latter. 

A Mac Mini with 16 GB of unified memory can run a 9B-class model (or Spark-X2.5-4B, which matches or surpasses Qwen3.5-9B) and get the basic stuff above done. Sure, it will be slower than the cloud tab and afford you not the maximum context; except it's not so clear cut. Spark-X2.5-4B gives you the speed of a 4B, the quality of a 9B, and more than enough context to fill the rest of the VRAM, besides the compute-buffers headroom. Pair it with a DSpark drafter GGUF and it will probably go even faster. Sure, it's one chat at a time (or run it with `--parallel N` with `N > 1`). Sure, it's not as turnkey as opening a browser tab. Sure, it's not ChatGPT `$CURRENT`, but it is most certainly better than ChatGPT 3.5, and it will get your normie use cases done. Wire up an uncensored GGUF for things that the base model will refuse to do, such as being overly blunt and cussy towards you, if that's your thing.

And if you face a usage spike that demands compute capacity to parallelize and go faster, e.g. for agentic coding? Provided that you don't care about privacy or Zero Data Retention, buy DeepSeek Platform credits for DeepSeek Flash or a Qwen token plan that will give you access to Qwen3.8-Flash. If you do care about ZDR and keep facing usage spikes that make your one box feel limiting, buy credit on OpenRouter, tick the ZDR-only checkbox, and cross your fingers that the checkbox actually does something. Even better: invest in a second box and scale your compute capacity and your costs in steps that amortize, and stop caring about where your data ends up; it stays here. You do not need to swear fealty to a cloud despot for basic stuff.

### The hot rods are not the market

The danger is that we are inundated with hot takes from people who
feel they need full-precision weights on a stack of $5k to $10k DGX Spark or Mac Studio units, because they are spending their time more with tuning their "hot rods" than actually using their "vehicles" for anything other than "AI-maxxing". That is their prerogative, fine. Tuning the `llama-server` arguments to fit a model and have it run at maximum context and at good quality is a rite of passage, and thankfully one that an agent can easily do for you after the first few times. However, let's be clear: tuning a very expensive rack instead of getting work done is not the bulk of the market; it's an AI consultancy business, a hobby, or both. The more limited the hardware you own, the more you care about extracting the best out of it. ROCm/HIP or Vulkan builds of llama.cpp? q8 KV cache or asymmetric q8/q4? How many drafters? Once you answer these and more questions, or your first deployed model or a cloud model does this tuning for you, at some point the actual work can be performed.

The local-AI market is in the early-adopters phase. Most people you see posting on X or HuggingFace are not the mass market that represents a future "Windows XP era". The market will need to cross the chasm, eventually. As we established, the mass market does not need trillion-parameter model capabilities. The enthusiasts and the SOTA fanboys take *their* use cases (agentic coding, a bajillion tokens burned every week, multiple concurrent sub-agents, decked-out harnesses with tens of skills, refactoring codebases, rewrites into Rust, etc.) and declare local AI "useless" because a sensibly-priced rig cannot match the affordances of a subsidized subscription plan (at least, not until the weekly usage runs out...) or the throughput of incredibly expensive per-token API costs.

True, as a trade-off, for *those* use cases, but then again **those use cases are not representative of a maturing market**. They might be the majority of *spend* right
now, but the long tail is not rewriting code into Rust or doing genome research, or electronics research. The long tail is comprised of people using Gemini Flash or ChatGPT for free, living with "you're doing this too much, come back later" and switching to a free model (or _another_ free model), and asking ultra-basic things, i.e. using the
thing as a search engine that can also chat with them.

### The prisoners of the Cave are recruiting

If you listen only to the Veblen-priced cloud serfs, you will believe that the only way to get _anything_ done is to become the same loud-and-proud serf stuck in a cave that they are. What's worse: the prisoners of the cave are recruiting others by spouting off nonsense about how amazing the cave is. This is a result of a mix of identitarian nonsense, a sense of superiority from paying tribute and showing off how much tribute they are paying (i.e. portraying subscription costs as a proxy of how advanced they are at using AI), and -- perversely -- a conquered status they want everyone else to share. It is laziness? Is it because they are spending their employer's money? Who knows? Statements about local AI being "useless" remain increasingly weird.

I understand that the lingo I'm using might come across as overly dramatic. You pay $100 or $200 per month and move on with your life, and your work. I have to build a dual-5060 rig to run models that are 6 months behind the curve, tune llama.cpp arguments, manage a llama-swap server, configure a harness.

Unless you consider that I do this _once_ and never have to pay ever again. And I also enjoy doing this, and learn a lot of things along the way.

Oh wait, am I also in a cave of my own making? 

Of course. AI bros are in their own cave; a "cave" can also be called a "scene". Self-hosting geeks are one too. Local AI connoisseurs are another scene. 

Heck, this whole page is part of a scene, isn't it? I make the claim that the cloud service provider that you treat as the only option to get your work done in a way that you do not consider "useless" is getting disrupted left and right on their way to an IPO that's based on financial projects that they cannot justify, and a super-weak profitability, while investors have started pulling their money out of datacenters and related infrastructure. I also make the claim that if either or both of the duopoly companies goes under, you'll be left having no access to the cloud services that you have grown dependent upon. You'll then have to "settle" for using subscriptions or token plans of non-American vendors that you now claim are "useless".

If this happens, or if miraculously those two companies go public and start charging you more for the plan so that you can keep getting your work done, what will you not accept? After all, their shareholders will pressure them for moar profit.

Will you accept $500 per month? Probably. $1000? Maybe. $2000? Perhaps, if desperate. $5k per month? Unlikely, except if the business is footing the bill, but by that point the economic case in favor of developer-labor substitution kinda falls apart. Oh well, you could go back to coding by hand. Or to one of those allegedly "useless" models.

If local-AI fans are in a scene, so are the cloud-AI fans. The difference is that one side has better marketing, which is easy to do, because the other side has close to none.  Paying $200 or more per month and staying put in your slanted perception that the vast majority of tasks requires you to keep paying tribute to you cloud overlord(s), so that you will be granted a "reset" now and then, to remain hooked on the weekly-allowance drip they have you on, so that you can still "do AI". 

And the truth, at least while DeepSeek Platform and Qwen Cloud and OpenRouter still exist and bill as now, is that _there is no scene_. It's all nonsense.

## There is no scene; I misled you

**There is no scene.** The we-versus-them nonsense is just that. Nonsense. I deliberately tried to piss you off, for rhetoric effect.

It's not about local vs. cloud. It's local/private **and** cloud, based on an evaluation of tasks, their functional requirements and complexity and other requirements, such a privacy, speed, sovereignty, throughput, security, etc. It's about making a mini business case and acting based on a proper evaluation, such as:

- Should I be attaching my bank statements to a ChatGPT chat?
- Should I be uploading my customers' tax data to a Claude chat?
- Does it make sense to pay for Haiku for this trivial task, when a 9B-class local model will get it done equally well?
- How many people does the local AI setup need to support, concurrently?
- Do I have the capital and the wherewithal to send some days to build and configure (and then maybe now and then babysit) a 32 GB budget box, a DGX Spark or an RTX Spark?
- Do I want to learn about "local AI" anyway? Do I care?
- What business risks are we exposing ourselves to by going all in on the easy solution of paying cloud subscriptions?
- What business risks are we exposing outselves to by hosting uncensored/abliterated models?
- When do I use Qwen3.8-27B, and when should I just use Grok 4.6, or DeepSeek V4.1 Flash, or anything else?
- What exactly justifies the cost of local inference capacity, and under which conditions?

It's all about matching Jobs To Be Done, i.e. requirements both functional and non-functional to a _mix_ of local/private and cloud spend. That's it.

### Still, there's a moral hazard in going cloud-exclusive

Imagine the late 1990s with the rent-seeking mindset espoused by the idea of a cloud subscription for access to what will most likely amount to a fundamental shift of how this world works, regardless of how Anthropic's and OpenAI's IPOs pan out (or dont). Imagine being back in 1995 and having to pay a subscription for the privilege of writing a document in Word, Word running an opaque classifier on what you may type and censoring what you can write based on Microsoft's Terms & Conditions, a meter on AltaVista searches... Disgusting. That's not personal computing.

Value creation with AI at planetary scale will not happen because a department of 20 became 2 people burning tokens like there's no tomorrow. It will happen the way the personal-computer boom happened: more people get access to **private AI capacity** that is limited only by what money they feel comfortable spending on their AI hardware, just like in the 1990s we were only limited by how much money we feel comfortable spending on a new PC with the Pentium 133, because the one we had already was none or the 486DX2/33, where (for the younger ones) 133 and 33 denotes MHz of a single-core CPU, i.e. what has now peaked with modern consumer-grade CPUs at around 4.5 GHz and God knows how many cores and threads. And that 33 to 133 MHz jump happened over the span of almost exactly **3 years** (DX2 in 1992, Pentium 133 in 1995). Crazy, right? About as crazy as the jump from ChatGPT-3.5 to Qwen3.8-27B.

**That**, in my view, is where we are right now with local AI models, and latest by the release of Qwen3.8-27B: in the Pentium 133 era-equivalent. Some might even argue that we are even earlier, i.e. at the 286/386 era, where personal computing **really** got started, albeit without the niceties of Windows 95 that brought a PC into every home that could afford it. How can you **not** be excited by what the future may bring? What will the "Ryzen 5 3600/5600"-class (the all-time individual desktop bestseller of the modern era, powerful and affordable, and still in use) local AI model eventually look like?

And how can you not be distrustful of everything and everyone who disparages that timeline, claiming instead that local-AI is useless, because it cannot one-shot a simple videogame, i.e. that 27B parameters of "world knowledge" are not sufficient to have captured and later regurgitate that videogame in functionality and looks?

Now, just to be clear: one-shot benchmarks are not entirely useless. If you define your own benchmarks, then how a model performs on those can still give an impression of what you might experience in real work. I know because [I'm doing it myself](https://overbring.com/ai-benchmarks), with a simple Elixir-focused one-shot prompt and a needle test that together aim to answer the question: _"can I trust this model as an Elixir coding sub-agent even for the basics?"_

But note that it's not a test of whether the model can clone Pac-Man, or build a trivial SaaS app that is effectively a Trello clone that the model has certainly "seen" in its dataset, or draw a 3D pagoda, or draw a damn SVG pelican, or any of the many good-looking one-shot benchmarks that make for _great_ YouTube videos, but eventually end up in training sets.

You need a few benchmarks that accurately represent the nature of the work you are going to use a model for in real work. You need to know whether the model (and the choice of quant, and the harness, and the temperature sampling, and the KV cache quantization, and the skills and rules you regularly use...) will give you a feeling of "this was a waste of time" or "hey, I can trust this" _for your own work_.

## The trade-offs are real

It's not all roses, and local AI is a different kind of beast than a subscription plan. Local AI is not "like what you run on the cloud, but free and private". It's closer to:
- What you could run on the cloud a few months ago,
- maybe a bit slower, maybe a bit worse,
- not as many sessions as you want in parallel, and
- a capital expenditure instead of a subscription.
- And instead of a pay-as-you-go for tokens, you pay-as-you-go by the kWh.

Fair and square: in terms of cost per token, local AI in 2026 cannot compete, except if you stole the hardware and/or you live in a USA state with very cheap electricity rates, or if you have a photovoltaic installation (which, by itself, is CapEx again, but I digress).

And even so, [token-generation speeds are not a good indication of model quality](https://overbring.com/blog/2026-08-17-qwen3-8-27b-wall-clock/). The real question is not how fast the model generates text, but the total wall-clock time to **correct** output, including the tokens and time burned by an orchestrator model that reviews the output and any sub-agent that implements fixes. We need to optimize for task completion, not tok/s.

This skews the balance against local AI, in fact, _for bounded-context tasks_, but in favor of local AI for investigative, unbounded tasks. I'd rather not send Grok 4.6 on a bug hunt across three codebases without any expectations of the time it would take to find the bug and fix it, because it might come back with my weekly usage meter shooting up from 5% to 35% in less than one hour. In that case yes, I'd rather run Nemotron-3.5-Lightning as the orchestrator of Ornith-1.5-35B-A3B sub-agents that will surface hypotheses that Qwen3.7-27B sub-agents will investigate and perhaps hand over to MiMo-V2.6-Distill-Qwen-9B sub-agents for mechanically trivial implementation.

Yes, the local-AI approach will take longer, but the idea is that the scarce resource of a token plan or the expensive resource of PAYG API tokens are better suited for planning and adversarial review, capacity overflow (if it's cheap like Qwen3.8-Flash or DeepSeek V4.1 Flash, and IP is not at risk), and the fixing of bugs that the local-AI approach could not deliver on. For what it's worth, I have stopped using Grok 4.6 all that much, because Qwen3.8-27B and Qwen3.8-Flash _on my codebases_ (most of which have are hand-coded and meticulously architected, refactored, and throughly documented by local-AI models with patterns and cookbooks) and with my own skill files, get the job done for months now, without any need to engage the increasingly expensive Grok models.

Anyway, with local AI tou pay differently, and you _wait_ differently, and pretending otherwise is how you lose the argument with someone who has a credit card and multiple $200-per-month subscriptions or has been granted a budget for corporate use.

### Context versus concurrent chats

On 32 GB of VRAM you can hold a 256k-token context, which is
workable, and if you actually *use* that whole window you pay in
throughput. One session, maybe two, depending on how you split the
post-weights and post-compute-buffers VRAM into slots. Maybe you run 1 slot with 256k context window. Maybe you run 2 concurrent slots, each with 128k context, or 4x65k. Any of those three is totally workable for the basic things that normie use-cases require. 128k is IMO the bare minimum for agentic coding, because models like Qwen3.8-27B reason a lot, and therefore a large part of that context window will be used for reasoning about how to get things done.

256k is more than enough for the vast majority of use cases. Models with a 1M context window anyway start to lose coherence long before the window is exhausted, so the "but muh 1M context window" argument is moot if the model gets Alzheimers at 320k tokens deep. Not every model behaves the same, and this might be an effect of cloud-AI providers temporarily serving "dumber" models, i.e. more heavily quantized models and or KV caches, during peak demand. 

### You never know what you are being served

Then again, that is another chink in the cloud-AI hypers' armor: you never know what exactly you're getting served. In fact, that one model that you _really_ liked working with? Yeah, that's gone, eventually. Bye buy Grok 4.20, 4.3 (not 4.5, it was a step down). Bye bye Grok 4.6. Better step up to Grok 4.7, you serf. Yeah it's 2.5 times the token cost than 4.6, and yeah, your $30 SuperGrok won't even last half a day -- but **it's SO much better!** (you just need to pay for SuperGrok Plus now, but you have the money, right? You have all your chats here already. Come on, what's $100 between friends? Come on, try it, it's worth it, I pinky promise. Well, until Grok 5 lands, then we'll see, maybe you'll have to pay $200/month then, but OK, I give you a **frontier** model...) It's enshittification wave after enshittification wave. It's akin to shrinkflation. You don't actually **need** the performance of the bajillion-parameter next-version model. But the cloud provider needs to _somehow_ increase its revenue. Easiest thing without raising the price of your current plan:

1. Launch the new and better model. First week, run it at full precision, glorious full-precision KV cache. The fish bite. YouTubers post "`$MODEL` is INSANE!" videos with mouth-wide-open photos and the same old boring one-shot "benchmarking" prompts. Keep it like this for a week or so.
2. The honeymoon period begins. More YouTube "benchmarks" are posted. Early adopters of the new model praise it. Demand rises, speed drops, latency increases. Drop quality by serving a quantized model and/or changing other settings like the KV-cache quantization. Add a feedback button below the responses on the chat UI on the web, so that you can lure people into giving you a signal about their sentiment.
3. Adjust model quality so that complaints are not that frequent. Token burn increases, because the new model eats through weekly usage caps faster than the previous one.
4. Some users churn, some stay. The ones that stay choose to chase the dragon of higher usage caps by switching to the next-higher subscription plan. Do not allow plan downgrades.
5. Milk the cows, hope they won't churn.
6. Go to step 1, repeat.

> Yeah, I'm jaded. Before Grok 4.3 or 4.5 was introduced, before the weekly usage caps, $30/month for SuperGrok was the best value for money. That has not been the case for quite some time now. Grok 4.3 is not available in Grok Build's model picker or in the web UI, and neither is 4.20, which had the multi-agent feature that was the best model I ever used. Burned once, never again.

Where was I? Ah yes, context-concurrency trade-offs. But anyway, say you want more than one session at once, or a subagent or more. In `llama-swap` (an orchestrator that allows you to serve multiple models that get hot-swapped into VRAM/RAM) all that is just model profiles: four slots at 64k, or two slots at 128k (a main that does the work and a slot you delegate to), or one slot at the full 256k. Agentic flows (take this document, call an API or an MCP tool, do something, call something else) typically want about 64k as a floor, so a native 256k model gives you four concurrent jobs if you are disciplined.

Having two different models co-resident is a hassle; you are fighting VRAM by hand, and VRAM is the scarce resource, so it's better to have one model's weights in VRAM. Swapping models costs wall-clock: load time is a few seconds from an NVMe SSD, longer from a SATA SSD, and what feels like aeons from a SATA HDD. And then, you pay for "prefill", i.e. for the VRAM to get populated by a re-tokenized context of your discussion thus far. Cloud does not make you care about any of that, though you still pay in terms of tokens burned when you switch model. 

With cloud AI, you burn tokens, the harness dispatches multiple parallel sub-agents (each without the workers-versus-context-window trade-off that I explained above), you get there faster and you also empty the weekly usage pool faster. Capacity is the vendor's problem. They scale up and down, sometimes they serve you a dumber model version, they give you another subagent session, but you can parallelize work. That is, it remains the vendor's problem until the invoice arrives; then, it becomes your problem. Your operating expenses grow. Fair, if you can afford it.

Still, as we saw, "home AI" is not that use case. Match the requirements of the task(s) and the access patterns to the technical solution, not the other way around.

With local AI, if your job is to code all day and you need that kind of fan-out, you put together a second GPU box and you start building a small fleet, each with its own `llama-swap` server, which is a real barrier for anyone who is not an enthusiast right now. Most people will not put up with the effort needed for the setup and the orchestration, i.e. the cognitive load of knowing which server has capacity to send the next prompt to. That does not make the single-box case fake, it just means that the use case of _"I need 5 parallel subagents to run at full speed and costs be damned, because I have a hard deadline for the next software release"_ is a fundamentally different Job-To-Be-Done / requirement than _"a family or business PC that helps us get the menial work done"_.

If you are in a company that requires coding capacity for more people at once, then the "speed limiter" of a budget rig is a deal-breaker. That's when a beefier local box and/or a cloud subscription is your way out. My budget dual-GPU build won't cut it.

### Having to wait means an opportunity to observe and to think

That is a genuine trade-off; for some kinds of work it is limiting. For a lot of work it is just slower, which means you wait. However, waiting is not always bad. Waiting means that you have to be more deliberate with what you do, especially if you use that limited local-compute capacity and sub-SOTA local models to get agentic-coding work done. It means that you cannot simply "vibecode", expecting that the model will read your mind and arrive at an implementation despite your lack of effort at setting constraints and requirements on what will be developed, and how.

You will need to discuss about requirements, provide a nudge, ask a correction, and you can do that better by **front-loading knowledge** instead of front-loading decisions. Start a 128k or 256k session, use [Handy](https://handy.computer/) for Speech-To-Text, and just explain what you are after. Braindump on this thing. Give it your idea, your concept, tell it your worries -- after all, nobody is listening! Everything remains local. If language models (whether small or large, because today's small is last year's large) are good at anything, it's in natural-language processing, so give it context, copiously so. Ask it to organize what you told it, to build an outline. Ask it to find gaps that deserve to be closed. Ask it to grill you, or ask it to review your input adversarially, i.e. poke holes into what you explained. Ask it to evaluate whether what you provided is sufficient to get started with implementation; it most likely won't be.

Put in the effort, and a model like Qwen3.8-27B is more than capable to help you till the ground before it starts planting seeds. Heck, even Qwen3.6-35B-A3B is more than capable of doing all that. Then, once you've done that necessary prework that vibecoders and one-shot benchmarkers apparently do not do, **then** you can proceed with a structured approach, again. Requirements, architecture, specifications, implementation, tests. All this keeps you in the driver's seat. Vibecoders and those who rely on the trillion-parameter SOTA model to "bake a glorious cake" without providing any other guidance will get... whatever cake the model regurgitates from its training data. Then, they'll keep spending tokens like the good serfs they are, in order to make the initial cake into the cake they want, but have not bothered to specify. They don't drive the process; they are the ones being driven into a trial-and-error, wasteful process that makes the vendor very, very happy. The are what is called a "meat proxy". Now _that_, yes, is derogatory.

Thus, having to wait is a blessing in disguise. Being forced to stay in the loop is how you avoid cognitive surrender on the 
task. You still know what is going on, because you went and kept going through the **necessary** value-adding work that is, essentially, knowledge management for your clanker buddy, and for yourself, and for anyone else who might work with this or a different clanker buddy on the codebase.

Then again, that is the agentic-coding use case, which as we've established does not represent the Windows-XP-era majority, i.e. the long tail of the market that will actually bring in the bulk of the money in the long run. Not every use case needs 32 GB of VRAM, and not every use case needs four
slots, and not every use case needs more than 64k of context. A Qwen3.6-class Mixture of Experts model with a 262k window,
split across two slots, is already two conversations at once, i.e. it serves two concurrent businesspeople, or mom and dad. Split the VRAM four-ways, and now a family or a small business gets its work done in parallel. Slower, yes, but not blocking each other.

Plenty of people on plenty of days, need just one chat going at once. Even plenty of small businesses will rarely need more than one concurrent session. The human is the bottleneck, until you start automating things with agents that do things autonomously, and that is still, firmly, not mass-market territory. Judging local AI against the built-in, token-burn-incentivizing laxity of a cloud subscription is a category error. Use cases have
requirements. A million-token carrot that auto-compacts and bills
you for the reprocessing is a smart way of burning more tokens so that you don't even suffer the temporary inconvenience (oh mon dieu!) of handing off to a fresh session. The advertised 1M context window is how they get you to stay in one session until compaction
fires; periodic token burn through automatic compaction is one of the ways in which they eat through your plan's weekly affordance so that you will eventually, maybe, be enticed to jump to the next-bigger plan. The closed-source harness
that "just works" by spawning sub-agents is the same token-burner with a friendlier face, cute animations, etc. Don't fall for that.

### The user experience is not yet approachable

Setup knowledge is a barrier to entry. `llama-swap`, slot counts, KV cache and its quantization, speculative decoding, parallel slots,
which quant affords you how much context, etc. We are early in a boom; of course the UX is still
ugly. It will get easier, no doubt. Enthusiasts will put up with the hassle, but the Windows 95 masses will not, until someone packages it. Some already do that, with nice GUIs that help you easily load models, but in my experience they still expect a lot from the user (_"WTF is Q4\_K\_M?!"_), and the automatic choices they make are not smart enough so that the user can squeeze maximum performance from the hardware. That's fine; the hassle in this phase still does not make the underlying capability of local AI any less impressive.

Still I have talked to people who claim that managing a local AI rig is practically a full-time job. I've heard of horror scenarios that I have not experienced not only with my own workstations with GPUs, but rarely also across my fleet of Proxmox VE servers:

- **Which quant to pick?** Trial and error, until you learn guesstimate what quant size typically fits what VRAM/RAM with the context window you need. Works well, because you anyway end up playing around with the same 2-3 model architectures. Can surprise you if you try out a model that's old, dense and more expensive per token in terms of KV cache than more modern architectures (e.g., Ministral-3), or is a 3B model with looped transformers (Nanbeige4.2-3B) and thus behaves more like a 9B+.
- **NVIDIA and CUDA driver installations.** Totally no issue on Debian 13. Piece of cake. Anyone who complains about NVIDIA on Linux hasn't tried it in years.
- **CUDA/Vulkan/ROCm OOM.** Well then, someone messed up the configuration. Easy to fix. Shouldn't have happened after the initial setup. You _did_ do a smoke test after you wired it up, right? Skill issue ;-) Besides, Qwen3.6-35B-A3B and better knows enough to read the HuggingFace card and estimate by itself the KV cache cost per token, and pick the right context window under predetermined conditions (e.g. q8 KV cache, q4 drafters' KV cache, MTP n=3, etc.) so that it boots right the first time. You should not need to wire models in llama-swap by hand after the first 1-2 you've wired up. You don't even need to `hf download` by hand.
- **Disk(s) full.** Well then, stop downloading and wiring up every hypetune on HuggingFace! Only a few models are worth keeping around, maybe in 1-2 different quantizations per model per machine: one static, and maybe one EXL3 if you can find it. Later on I have a table with some of the models I host on the dual-5060 machine. I have marked those I use most with an asterisk. The rest is long overdue for pruning.
- **Unexpected PC component outages.** Had this happen twice on two different Proxmox VE servers, because of btrfs on budget TeamGroup CX2 SSDs of the same batch. Restored backup and was up and running again within the same day. No big deal. That's not even worth mentioning as an outage for internal business stuff.
- **GPU dead.** Power-limit your GPUs. Inference is memory-bound, so there's no sense in spending an extra 40 W to run the core clocks at maximum speeds just to avoid a 5% to 7% drop in token-generation speeds. Prolong the life of the silicon, because it's currently the scarce and expensive asset.
- **ROCm/HIP or Vulkan on AMD?** ROCm requires more VRAM for compute buffers, so it reduces your affordable context window. ROCm is generally faster in terms of prefill, and Vulkan is faster in terms of single-stream token generation. ROCm wins on aggregate token-generation speeds with more than one slot. That's a rule of thumb, and you should let an agent test both, because it very likely depends on the model architecture. Grab the latest [lemonade-sdk/llamacpp-rocm release](https://github.com/lemonade-sdk/llamacpp-rocm/releases) and build mainline llama.cpp with Vulkan. It's dead simple.

As for reliability overall: when some weeks ago Grok, OpenAI and Claude were doing for hours straight, it seemed as if work around the world for some people ground to a halt. My llama-swap server kept working. So there's that.

But OK, besides the cheekiness, I know, it's not easy to get started. Windows 95 also won because it was a _product_. It was a package deal. It was easy to install (even though buggy as hell) and it had a very simple to understand UI. If there's any change of local AI having its Windows 95 moment under the sun, what we currently have is more like Slackware in 1993 than Windows 95. More on the packaging issue later.

## Capital expenditures vs. operating expense

A cloud subscription or an OpenRouter invoice is operating expense: pay-as-you-go, or a
plan that pretends to be a buffet until the weekly pool of tokens is dry. Note that they never show you tokens, they show you credits or a percentage, or money left. This way you cannot calculate price per token.

The other thing is that it depends on organizational setup. You can more easily expense a plan invoice. Capital expenditures usually require a budget owner and approver, accounting to take into account depreciation, a place to put the box, and someone who will be around long enough so that the box doesn't become an expensive ornament.

But again, that's putting the cart of organizational dysfunctions before the horse of organizational needs, if indeed your business case shows that cloud _and_ local AI both add value with the right mix. Small firms like mine can buy a box in an afternoon; no requisition needed, no approvals, nothing. Large firms are a different model. How "large" large is, is another story.

A local box is capital expenditure up front, then electricity, then
almost nothing when the fans are not spinning, except for the electricity cost of an idle PC (40 to 80 W). One year of a heavy
cloud plan is already in the neighborhood of the cost of purchase a capable local rig with 32 GB VRAM.
In year two, three, four you keep paying rent on capacity you could
have bought. Maintenance, by the way, is one of the first jobs you
can hand to the box itself: after weeks of wiring HuggingFace models
into llama-swap's `config.yaml` by hand, I asked Qwen3.6-35B-A3B to
turn the ritual into a skill. For months I have pasted a model-card
URL and let the agent fetch the weights and write the profile in `config.yaml`. Another menial task off my hands.

The other upside of local: you always know what you are running. You
learn what quality to expect for what kind of input. Nobody serves
you a worse quant because it is peak time in Beijing or San
Francisco. Nobody retires the workhorse model you finally learned to steer and also how far to trust. Want that old cloud model back? Stick
to an older model on OpenRouter and you often pay *more* per token. Qwen3.8-27B plus web search and web fetch already covers pretty much anything that is not a super-niche research toy. Put in some more elbow grease, roll up your sleeves, and you can have your harness use a local SearXNG instance for web search, and a local Firecrawl instance for web search and document conversion to Markdown. Privacymaxxing is no big deal.

Qwen4, when it drops sometime in November 2026, will be a nice-to-have upgrade on silicon you already own. That is a rare case in technology: the equipment sits still, the models get better, and so you get better outcomes without further capital expenditure.

### What a token actually costs

Say you run Qwen3.8-27B NVFP4 on 32 GB VRAM. You will not run it 24/7.
If you did, you could put the output tokens next to API list prices
and next to a plan's monthly allowance. From this server's
llama-swap SQLite log, average tok/s regardless of context depth:

```sql
SELECT AVG(tokens_per_second) 
FROM activity 
WHERE model_id = "Qwen3.8-27B-NVFP4-vision";
43.4856426336161
```

At 43.5 tokens per second, that is about **114 million output tokens
per month** if the card decoded every single second of the month. Yes, that's naive:
it ignores prefill, which burns watts and wall-clock without filling
the "output" column, and it ignores the fact that you are in the
loop. Kept simple, output only.

[OpenRouter list prices](https://openrouter.ai/models?input_modalities=text&categories=programming&order=pricing-low-to-high),
USD per million *output* tokens, times 114.3 Mtok. Qwen3.8-27B is
not Opus 5.5, that's clear. A 27B will not have the same performance as a frontier cloud model, but the question is not whether it has the same performance; _does it get the job done?_ That is the question. I added Opus 5.5 and Astra anyway, out of curiosity.

| Vendor | Model | Output (USD/Mtok) | USD for 114.3 Mtok |
| --- | --- | --- | --- |
| SpaceXAI | Grok Build 0.1 | 2.00 | 229 |
| SpaceXAI | Grok 4.3 | 2.50 | 286 |
| Google | Gemini 3.6 Flash | 3.75 | 429 |
| OpenAI | GPT-5.4 Mini | 4.50 | 514 |
| OpenAI | GPT-6.1 Terra or Sol | 5.00 | 572 |
| Anthropic | Claude Haiku 4.5 | 5.00 | 572 |
| SpaceXAI | Grok 4.7 | 7.00 | 800 |
| Anthropic | Claude Sonnet 5.5 | 10.00 | 1143 |
| Anthropic | Claude Opus 5.5 | 20.00 | 2286 |
| Anthropic | Claude Opus 4.6 | 25.00 | 2858 |
| OpenAI | GPT-6 Astra | 50.00 | 5716 |

Now the inverse. Call it **$3000** to build something like my
dedicated box: E-ATX case, X870E, Ryzen 7 9700X, 1x16 GB DDR5-6000, 2× RTX 5060 Ti
16 GB on PCIe 5.0 x8/x8, 850 W 80 Plus Gold PSU, SATA SSD for Debian 13,
NVMe for weights. The 5060s are power-limited at 160 W, which drops token-generation speeds by a few
percent while prolonging the life of the scarce asset: the silicon. At the wall, with both GPUs at full blast, the box draws **500 W** sustained.

That is about the cheapest *useful* dual-GPU 32 GB CUDA rig you can
assemble in late 2026. Paying tribute to NVIDIA is, however, not the only path, though I do like the NVFP4 prefill boost that the Blackwell archutecture provides. Dual RX 9060 XT 16 GB is da AMD wae: always cheaper per gigabyte of VRAM, ROCm/HIP builds of llama.cpp by the Lemonade project or your own Vulkan build of the mainline llama.cpp instead of CUDA, and no NVFP4. You get MXFP4 instead, and you usually lose on prefill; generation can be close. 

Dual 9070 XT right now (November 2026) is a different shopping trip, because those cards sit nearer a thousand euros
each (incl. 24% VAT, in Greece). They are also more power-hungry, so you'd need a bigger PSU as well. All this combines to blow the "budget 32 GB" thesis, and brings the total cost nearer to $4k. GPU street prices move weekly. The 5060 units I got for €580 (incl. VAT) are now at €780+, and I've seen the cheapest model reach €880. The RX 9060 XT I got for €399 (without VAT, intra-EU purchase) is not at €700+ (incl. VAT).

The point is 32 GB of VRAM on two modest cards, not a 5090. You cannot time the market, but €10k for a 5090 clearly is not the right path for local AI. Dual-5090 would give you insane speeds, but at what cost per Mtok?

### Equipment-cost amortization, and electricity

Let's assume **$0.40/kWh** for electricity. That is high for cheap-power US states,
high for some EU countries, roughly right for expensive-power EU
households (Eurostat's EU average all-in is nearer €0.28; Germany
and Ireland live up near €0.39).  It's a conservative that works against the local-AI business case, and that's on purpose on
purpose. 500 W × 730 hours/month × $0.40/kWh ≈ **$146/month** -- _if_ the box
generated every hour of the month. It will not, so that's a simplification.

Next, amortize the $3000 **straight-line to zero**: cost ÷ (years × 12), with no residual, no interest, no resale. I am *not* counting that you
might sell the cards into a drought for half, or more, of what you paid. That would make the local case look better than I want to claim.

| Straight-line years | Rig (USD/month) | Power (USD/month) | Total for 114.3 Mtok | USD/Mtok |
| --- | --- | --- | --- | --- |
| 1 | 250.00 | 146 | 396.00 | 3.46 |
| 2 | 125.00 | 146 | 271.00 | 2.37 |
| 3 | 83.33 | 146 | 229.33 | 2.01 |
| 4 | 62.50 | 146 | 208.50 | 1.82 |
| 5 | 50.00 | 146 | 196.00 | 1.72 |

Under this fictitious 100%-decode duty cycle, local is **not**
cheaper per output token than Grok Build 0.1 at $2/Mtok. It is in
the same band as the cheap APIs once you have amortized a few years,
and a lot cheaper than Sonnet and Opus on the open list. You also
do not get Opus quality. A $200/month plan, if you actually get
hundreds of millions of tokens out of it, is a better sticker price than
$146 of 24/7 wall power...

..that is, until you notice that you most likely do not run the rig on full blast 24/7, that Claude Code will chew a weekly pool for breakfast, and that the
plan is a meter with a smile and an ulterior motive. Plus, it's a bet on an uncertain future in which:

- The duopoly of OpenAI and Anthropic does not become a monopoly.
- Both OpenAI and Anthropic do not go out of business, pre or post-IPO.
- Plan prices remain roughly the same, i.e.:
  - the $200/month plan that now affords you X tokens does not enshittify into way less than X tokens, thus forcing you into e.g. a $500 or $1000 per-month plan for the same affordance.

I don't know about you, but I don't like to run my business on hopes and prayers, and since a lot of my operating efficiency now hinges on local-AI agents handling the menial stuff, I wouldn't want its evolution to depend on the whims of the duopoly, any potential regulators, doom-and-gloom BS about a Skynet-like apocalypse, or to not have the ability to launch an abliterated local agent on a penetration test against the software I develop, because a cloud AI vendor's self-appointed "AI wellness and mental-health guardians" might frown in disapproval at "but muh AI safety". The AI-safety cat is out of the bag, for better or for worse. There is no going back. There was never any chance of the cat staying in the bag for that matter. Tools are not dangerous, people with harmful intent are dangerous. Regulating the technology does not miraculously make such people stop and ponder. And yes, this Greek believes that this goes for _any_ tool, my USA friends of your Second Amendment.

Anyway, what the table refuses to capture is the "shape" of the cost. Cloud AI is
a hose. You want to burn more tokens? Buy more credit, but a bigger plan or more (and maybe bigger) plans. Have at it. OpEx baby, all the way.

### What the speed limiter actually is

Local AI is like a speed limiter, or rather a bunch of speed limiters. Here's an average of prompt-processing and token-generation speeds across a selection of the models I mostly run on the dual-5060 box. I've selected only those with hundreds of requests to that box's `llama-swap` server:

```sql
SELECT model_id, CAST(AVG(tokens_per_second) AS INTEGER) AS tps
FROM activity 
GROUP BY model_id
ORDER BY tps DESC;
```

> Models with a ⭐ next to the model name indicate what I use daily or frequently enough to justify keeping the model's weights on the NVMe. Not all those models are still around, such as KAT-Coder-V2.5, which was great until Ornith-1.5-35B-A3B was released.

|  | Model | `tg` (tok/s), rounded | Why use it? |
| --- | --- | --- | --- |
| ⭐ | LFM2.5-8B-A1B | 213 | Very fast chatbot |
| ⭐ |Qwen3.8-MoE-Distill | 178 | Coding sub-agent |
| | OxCoder-9B | 162 | Coding sub-agent |
| | DeepSeek-V4-Pro-Qwen3.5-9B | 147 | Coding sub-agent |
| ⭐ | Qwen3.6-35B-A3B | 137 | Fast coding sub-agent |
| | Mellum2-12B-A2B-Thinking | 131 | Fast coding sub-agent |
| | LFM2.5-24B-A2B | 124 | Chat about documents; never coding |
| | Spark-X2.6-4B | 119 | Summarizer and chat |
| | Qwen3.5-9B | 118 | Fast coding sub-agent |
| | KAT-Coder-V2.5 | 112 | Outdated old fast coding workhorse |
| ⭐ | MiMo-V2.6-Distill-Qwen-9B | 104 | Fast coding sub-agent |
| ⭐ | Nemotron-3.5-Bolt-74B-A9B | 103 | Orchestrator and coding agent |
| ⭐ |Ornith-1.5-35B-A3B | 103 | Main fast coding workhorse
| | Ornith-1.5-9B | 94 | Coding sub-agent |
| | Ministral-3-8B-Reasoning-2512 | 94 | European-language document analysis |
| ⭐ |Muse-Glimmer-30B | 79 | Main coding agent |
| | Ministral-3-14B-Reasoning-2512 | 69 | European-language document analysis |
| ⭐ | Nemotron-3.5-Lightning-30B-A3B | 68 | Orchestrator and long-session compaction |
| ⭐ | Swift-1.5-Qwen3.8-27B (EXL3 5bpw) | 64 | Slightly faster coding workhorse |
| ⭐ | Qwen3.8-27B (EXL3 5bpw) | 50 | Main coding workhorse |
| | Gemma-4-12B-QAT | 49 | Multilingual document analysis |
| ⭐ | Swift-1.5-Qwen3.8-27B (NVFP4 "Q8mix") | 48 | Coding workhorse |
| ⭐ | Qwen3.8-27B (NVFP4) | 44 | Coding workhorse |
| | OrcaSAQ-2-Cyber-27B | 43 | Penetration testing |

Clearly, the bigger the model, the slower it tends to get, with the exception of Mixture-of-Experts models. All those are set up for maximum or near-maximum native context window, and therefore any of those can be split two-, three-, four-ways. In some cases, like for Nemotron-3.5-Lightning-30B-A3B, you can split 1M eight-ways, so that you can paralellize sub-agents. However, in those cases the aggregate throughput does not justify parallelization, so I usually go up to 2 to 4 slots, depending on the task. Those are not shown here (I use the naming convention "`-x{N}`", where `N` is the number of concurrent slots), because I use these model profiles so rarely that data are lacking.

For the early-adopter who wants five parallel sub-agents rewriting a codebase, the speed limiter hurts, and so does the maximum native context window of practically all of those models (all of them 262144 tokens, except for Spark-X2.6-4B and Nemotron-3.5-Lightning-30B-A3B, both 1M, and the LFMs that train their models for 128000 tokens, as they target edge deployments where VRAM is too scarce for more context anyway, I assume). Agentic coding requires "long horizons" without losing track of what has already been done due to intermittent compaction that might not be selective enough for key facts to be retained between compaction runs. You just have to accept that you'll have 1 or max. 2 slots per box, each with 262144 or 131072 context window, perhaps with one slot acting as the orchestrator and reviewer, and the other as the implementer. That is where the second box comes in. In my case, subagents run on my desktop workstation with the unbalanced RTX 40-series GPUs, and sometimes on just one of them (the RTX 4070 SUPER 12 GB), in order to go faster.

For a family or a small office, where you'll typically have max. one chat at a time or maybe two, like "summarize
this PDF", "what do the emails say", "summarize the invoices' amounts", "extract the total volume and weight of the shipment", etc., the speed limiter is not that big of a deal, because sessions rarely exceed 64k or even 32k tokens. Turns are usually short too, especially when not using "chronic overthinkers" like Qwen3.8-27B (which will be overkill for chat sessions or agentic workflows), and so requester's turns can be interleaved, with the pending ones waiting. Since each slot has 32k to 64k tokens, even if a lot's KV cache is evicted for an extra request that doesn't fit, re-prefill cost is low, because it's in the high triple digits, so maybe one person waits for one minute now and then for their request to get served. It's unlikely that *everyone* in an office will be hammering the server at the same time.

However, when the box is not generating, the bill falls
toward idle: on this chassis, on the order of **80 W**, call it a few tens of dollars a month, not $146. Real use, in Open WebUI or Grok Build or whatever harness, is a few minutes of cranking through a few subsequent responses by one person in a flurry, then silence, then repeat. The duty cycle is then low, and includes prefill.

One last thing: duty cycle cuts both ways. If it's "a few minutes" of usage per day, then clearly, save your money. You will never generate anything close to 114 Mtok per month, so the API comparison ends up being theater. You'll just spend 80 W idle most of the time, which a PC that you wouldn't have left on, whereas a subscription plan's idle time cost is exactly $0. The 114 Mtok column is an upper bound for the sake of comparison, and idle power draw are a real cost of having a machine always on, 24/7. I leave the dual-5060 rig on because I often leave things running overnight. Alibaba's `open-code-review` runs of codebases, for example. If you don't, you switch it off, and local gets cheaper and slightly less convenient. Or put a Tapo P100/P110 Wi-Fi plug on it to turn it on every morning before the workday, and set a cron job to shut down in the evening. No big deal.

## The comparison that actually makes sense, for a business

Forget 114 million tokens. Put a clerk on the menial work already
described: email, documents, PDFs, spreadsheets, "where does this offer stand?", "which offers are expiring soon?", "what is the historical price of `$PRODUCT` in the past 2 years?", "has this order been confirmed by the supplier?", an executive summary now and then. Let's assume eight hours a day, five-ish days, fully loaded, which is overkill.

In Greece each employee costs a firm something on the order of **€1500/month** fully loaded. Most
of the richer economies are higher, at **$2000–2500**. The box, if we are unkind to it
and assume it generates at 500 W for those same eight hours every
calendar day, plus 80 W the rest of the time, at $0.40/kWh, is
roughly **$65/month** of electricity.

Remember that are assuming that the dual-GPU rig cost somewhere around $3000. Against €1500 fully-loaded cost of an employee, the rig's cash payback is **about two months**.
Against $2,500, closer to **six weeks**. After that, you are paying power and the occasional disk. The clerk still sleeps, still forgets, still cannot be audited the way a Markdown trail can. I am not claiming the model *is* a person. I am claiming that for the zero-value-adding alignment of documents, the cost of a local AI agent in a low-wage country breaks even against hiring an employee before the first quarter of the year is over.

Still, let's not be facetious. It's true that 500 W times 8 hours does not fully replace a human "clerk", or a personal assistant, or an operations manager. I am still in the driver's seat, but then again I would still be that even with an employee. Models hallucinate, humans forget and make errors. It's a wash. However, the fully loaded cost of an employee includes accountability, though that is debatable with modern work ethic. In my case, where my clerk human labor needs are less than 8 hours per day (because everything is in the meantime so far automated), the box solves another issue: the fact that I cannot find someone to do this job part-time. And for _that_ kind of workload and set of tasks the box has paid for itself in my firm in months *with me still in the loop*. If you need a human who can be yelled at by a customer, hire the human. Don't use my two-month figure as a justification of doom-and-gloom scenarios about future unemployment, though I'm sure that the box has removed a 0.5 FTE from the labor demand...

So, that is the ISATEK story: the dual-5060 box has paid for itself against labour in a handful of months, not against the spot price of $/Mtok (input and output) on OpenRouter, and with nobody getting access to the company's data either. That is one of the strongest cases for local AI capacity, and it's stronger than the operating expense argument. Privacy and flexibility, with a short payback period.

### Subsidized plans' prices are the bait to a switch

A $200 Max plan is a different animal. To be fair: $200 is more than idle power, and less than what a person costs per month. It is also tied to the fortunes of two
US labs if you stay in either or both of those pens. Plans have gotten worse, and who knows what the future may bring? People complain about chatty harnesses, shrinking pools, models that move under you, retirement of the models that worked well enough for you, before the vendor played the planned-obsolescence card. Accenture has reported engineers hitting **$500–$1000/month** on Claude before the firm capped them; reporting in the same season of **$500–$2000 per engineer per month** at other large buyers. 

If $200 is a promotional sticker on labour substitution, it is not unthinkable that the price on the sticker moves to match these reported economics, especially if/when the duopoly IPOs and is pressured to make its insane valuations a reality. API list prices can move the same way and for the same reason. Local's unpleasant property, i.e. that you bought a Fiat Punto with a speed limiter instead of a scalable fleet of Ferrari F40s then becomes a hedge against a future where everything is overpriced and the labor-substitution argument doesn't hold water. 

But still: the cat is out of the bag. Practically everything in a business can be done with a modern open-weights model that fits 32, 16, or even 12 GB of VRAM. That is also one of the reasons why I look at the proposed IPOs of the duopoly with as much skepticism as I look at the Fear, Uncertainty and Doubt that they like to spread about open-weights models, and particularly those coming from China. The duopoly knows that the vast majority of their use cases has already been disrupted, not only by frontier-level models from China (that many, justifiably, are distrustful towards, due to data privacy and intellectual-property concerns), but already by open-weights models that can fit the above pitiful (by datacenter standards and even DGX Spark standards) and cost-effective VRAM budget, and still get these jobs done far more than just "good-enough". It's the classic Clayton Christensen "Theory of Disruption" story. While the duopoly keeps wowing digital serfs with bigger, better (way better than required for most tasks) models that are expensive to train and expensive to deploy, Chinese labs have been releasing models that not only challenge the duopoly on the cloud frontier, but even "at home".

### The cloud overflow cannot be used for everything

> Chinese APIs already ate your cost argument. DeepSeek/Qwen token plans are the cheap meter *and* better than 27B. Local is then only privacy. Don't sell it as economics.

For the jobs I am willing to send out, yes: those plans beat my box on quality-per-dollar. I said they are excellent. Local's remaining case on those jobs is privacy, predictability, and not getting the model yanked. That is still a case. It is not "always cheaper."

Chinese APIs and token plans (DeepSeek Platform, Qwen Cloud) are excellent value for money. I use them for work I do not mind leaving the building. OpenRouter with a zero-retention claim is the same value-for-money play, as long if you believe that the Zero Data Retention checkbox is leak-tight all the way. Personally, I do not believe it, because there is too much data with valuable information sloshing around a system with too many parties, for this to be tightly controlled always.

That is why those API credits and token plans do not replace my boxes for privacy-sensitive or business-proprietary sessions. It is overflow for the things that don't matter, i.e. for the noise (throwaway software prototypes, code review and cheap refactoring of my open-source Elixir libraries, as two examples). The signal (all the things that provide data for fingerprinting persons, businesses, accounts, prices) remains local. I refuse to tie the horse or my business' "digital agentic AI transformation" (`inception_BWAAM.wav`) to OpenAI or Anthropic's wagon and its uncertain path, whether that path is eventually inexistent or overpriced.

As for the resale value of that pricey GPU rig you may buy or have already bought: in a drought you might get money back; after the next real GPU generation (and who knows when that will come?), an RTX 5060 Ti 16 GB may look quaint and sell for peanuts. Both can be true in sequence. I am not putting a resale value in the amortization table, on purpose: the used-card story is that of a *later* market, if the drought breaks, by which time your current GPU might be worth nothing or a lot, depending on what's available in the consumer new-GPU market. It is a scenario; if affordable GPUs remain scarce, you recoup more and the "peanuts" future is delayed. If they crash, you don't recoup and the masses get cheap 32 GB. Nobody knows which scenario might materialize, and if they know, they're better off playing the stock market. This is not a forecast and not financial advice. Don't count on your current GPUs fetching anything in the used market at some point, because that would not be a hedge, but a hope and a prayer.

The second half is the mass-market punchline: we have already crossed the line where **32 GB VRAM is more than enough** for the long tail. Heck, even 16 GB is enough. In 2
or 3 years, when wafer allocation is less deranged, a 5080-class card at 5060-class money with 32 or 48 GB is not a crazy scenario. Thenm the used 5060s and 9060s, or a single aging 5090 32 GB or Radeon AI PRO R9700 32 GB, will become the Windows 95 PC of this story: one card with more than sufficient VRAM for anything from chats to agentic business processes to agentic coding, bought cheap, used short stints, and most importantly: with the open-weights models that are yet to come. You do not need more VRAM than that for that job. You needed it for the hot-rod tuning, but tuning the hot-rod is not the market, but research or a hobby (or X and HuggingFace clout).

## Sovereignty, privacy, and not living in someone's cloud cave

Local AI's value proposition is: always on, nothing leaves the building, and you **buy** a limiter instead of renting flexible ("elastic") capacity. 

Cloud plans' value proposition is: the best models you can get, at a low-low price (that might get higher), but kindly do pace yourself until Friday, or you might not be able to do your week's worth of worth. 

I would rather own the limiter. But then again, I'm Greek, used to variability and unpredictability, and therefore also more attuned towards asset ownership and sovereignty of usage instead of service/rental, unpredictable future operating expenses. And I certainly enjoy living and working without the Damocles Sword of the fate of a duopoly hanging over my head and my business. Or to permit a vendor to tell me what I am allowed to do, or not.

To see how absurd the current situation that the duopoly is striving for is, transpose the current cloud deal back to 1995, and let's look at "alignment", "AI safety" and "safeguards". Someone tells you that a personal computer will cost the equivalent of €100/month, and that Microsoft Word will refuse a sentence because it breaches a safety policy, and that you may not search for a topic because it breaches terms of service. Oh yes, and even worse, that your account might get banned if you keep doing this.

First of all, whose job is it to tell me what I do with my computer? It is my computer. It was "My Computer" on the Windows 95 desktop way back when, it remained **my** computer long after I moved from Windows to Linux in 1997, and it does not magically become someone else's asset or turf to play around in and impose rules on, just because Microsoft decided to rename the icon to "This Computer" in Windows 11, or because the post-Global-Financial-Crisis boom of cloud-backed online services moved an entire generation and more to the convenience of digital serfdom in which "you will own nothing, and you will be happy" (I retch).

Kindly put, I will do what I want with my computer. That is not a brief for doing shady things. It is about who gets to classify the contents of your head as they pass through a keyboard or a microphone (if you use Handy or other STT tools to dictate).

The machine, and what you type into it, is an extension of what you have in your mind. Nobody has managed to censor that so far. Vendors are reducing their own legal liability by putting an imperfect classifier between your signal generators (fingers, mouth) and the input box. But there is no perfect classifier for complex things, let alone for the nuances of human language. Sessions that stop responding because a nanny decided you were doing "cybersecurity" research, or you might be researching ways of building LLMs that might end up outperforming the duopoly's models, or something merely _adjacent_ to a banned category, are the point. 

How did we inch backwards into something this illiberal approach being considered as anything other than despicable? How did we accept that notion of wrong-think from 1984, except the telescreen is now a ToS sheet and a model that is covering the vendor's ass? I do not want a nanny state overhead on anyone's thinking, including boring, legal, and personal/private thinking.

Oh, I have heard the argument already: classifiers not being perfect is to be expected, because a billion people use it. The risk to the cloud vendor is insanely high (you'd think, but I doubt it) if one jailbreak causes death. But didn't recently a lady die of an epileptic seizure because ChatGPT kept validating her idea of gradually reducing the medication? I didn't see anything come of that, so that worry is moot.

## Why people stay in the cave

I keep meeting people and reading posts by people who still think that the only way to use AI is the latest cloud model at an immense monthly cost, even for work that last
year's weights could do. Especially for coding, there is a large misunderstanding that the only way to get working software is whatever frontier name is fashionable this month, and that anything else is wasting time.

Some of those people are lazy, stupid, or both, but not everyone is either or any of those things. They are merely trapped in a cave, and by vendor machinations that are old to the point of being banal, and very well understood.

### Brand as product, and as identity, and as a hiring "perk"

For one, some people attach their identity (or some parts of it) as being patrons to the purveyors of the latest sexiest fad. This is what I call [Deft](https://leanpub.com/deft). It's the shiny new toy, and it's even better if it is unreasonably priced compared to alternatives that can be discarded as "for cheapskates", as "useless", etc. It is Agile, Lean, Claude and OpenAI models, as it is the iPhone vs. Android, the iMessage blue bubble, Audi variants of a Volkswagen automotive platform vs. alternatives, complex web-scale-wannabe software architectures like "more microservices than users" instead of practical, low-cash-burn, performant and scalable software architectures.

These people do not _need_ the thing. They just _want_ the thing. In fact, the brand _is_ the largest part of the product, and the product's price/performance ratio or its risks (vendor lock-in, price hikes, rug-pulling, bait-and-switch, privacy erosion) are less relevant than the fact that it's the "safe bet". It's what the herd uses, and there's safety in being in the herd that makes the "safe bet", especially if someone else is paying for that bet, like your employer giving you a Claude Code or Codex subscription as a job perk (it's a fucking tool, and you're a tool for considering a tool to be a perk), and you totally buy into this shiny toy without looking at the wider space of AI, and of local AI in particular, because hey, you are not the one carrying the business risk or the cost.

Oh, but then who will join our company if we don't make Claude Code and a plan part of the "perks"? True that. But then you have the problem of portraying it as a perk vs. just as a tool for the job. It's as if ABB Turbo Systems would have sold me the idea that I'd be using the latest CFD and FEA software on an HPC cluster as a perk back in 2008. Why, can I get my job done in any sensible way _without_ that alleged perk? If not, then it's not a perk. But sure, candidates want to CV-pad, so putting "Claude Code expert" or so on the CV before they job-hop is definitely more alluring than writing something about local AI models or so--you'd think. What exactly are you incentivizing with that "perk", hm?

Who even considers basic tools for the job to be a perk? Who even has to woo candidates that hard to hire developers nowadays, for that matter? Try selling them the fruit basket or the foosball table as a perk, you too can be like 2005-era Google!

### Nobody was ever fired for hiring the incumbent

You've heard it before: "nobody was ever fired for hiring X", where X has been IBM, McKinsey, Amazon; and now, the duopoly. Sometimes the motivation behind this is fiduciary. Sometimes it is "I like being in the herd" with a fiduciary costume. If your personal downside is a wrong verdict or action because you let an agent do things unattended, without safeguards for your specific process of knowledge work, guess what: you should not have been running local agents unattended on customer promises, much in the same way that you should not have run unattended *cloud* agents either. Remember the story of the car dealership with the chatbot that let a customer negotiate a massive discount on a Toyota? That. Don't do that. The safe bet that nobody reviews is anything but safe.

Corporates, often treated as the peak of efficiency vs. e.g. the much-derided (and justifiably so) public sector, are in reality also trapped in spending other people's money (the shareholders', their owners', their employees' otherwise-feasible salary bumps) on other people (must-have initiatives and rituals, expensive toys, latest fads, and so-called safe bets). And of course, the average executive prefers going with the "obvious" and "safe" overpriced solution because otherwise they look like laggards, or like they are rocking the boat. The larger an organization grows, the more it rewards conformity, which is another word for mediocrity over the long run.

Organizations that could very well afford not a budget dual-5060 rig, but a stack of DGX Spark units, organizations that already have IT staff that can be tasked partially with keeping the list of models up to date, organizations that claim to hold the best interest of the business in mind... they spend much more on the "safe bet" than betting on the actual long-term future of local AI, which is clearly data sovereignty and business continuity of all the things that increasingly rely on AI, not on the questionable fates of a duopoly with questionable agendas in an overheated hype market (a bubble), but on building competencies and compute capacity on hardware they own.

But then again, it's no surprise; we've seen that before. Miracle-cure frameworks and tools, alluring narratives of success at organizations that do not look
like yours, passionate experts discarding alternatives... The current cloud-AI hype is Deft in a new cloth.

### Some want expensive stuff for no good reason

You buy a very expensive German car and, because you paid a lot, you convince yourself it is the pinnacle of automotive. After all, everyone you know who is successful drives a Mercedes/BMW/Audi. Therefore, driving such a brand will make you appear successful. And even though these brands' quality has deteriorated, you are still willing to pay more, even though you are not getting more product for the price. But it's more exclusive, whatever that means in a world when one can lease. Cloud AI has the same Veblen structure. Twenty dollars, fifty, a hundred, two hundred a month, and rising, for the *privilege* of sending private and proprietary information to a vendor. Cache hits, cache misses, price per million tokens of input and output, a meter on a hose you do not own, and a hose that can be shrunk or taken away at any moment, or if you "misbehave". Subscriptions get encrusted. Usage pools shrink. Serving gets cheaper for them and dumber for you, and you cannot choose the quant. Locally you pick the trade-off yourself.

### You will own nothing, and be an unhappy serf

The rental shift is not new, and it started many years ago. for years, Dropbox was the safe bet, if you wanted to store and share files... only, it's a dying platform with nagging features so that you upgrade to paid, long after they bought market share by giving everyone with a pulse gigabytes bundled in purchasing laptops, cameras and other hardware. OneDrive hijacking the PC until it stopped feeling like *your* computer. App stores and walled gardens, and the hardware manufacturer dictating what you can run on the smartphone you paid for, in full, if I'm not mistaken -- because I do not remember getting a discount on the hardware under the condition that I'm not allowed to do whatever tf I want with it. In that light, recent successes at running iOS on cheap Android phones is such, such sweet Schadenfreude...

We went from ripping our CDs into MP3 and FLAC, to renting the ability to listen to whatever Spotify offers in its catalog. Office became a subscription product. Microsoft wants a tribute, Spotify wants a tribute, Apple wants a tribute, Google wants a tribute. For storage, for usage, for ultra-basic things that 2 decades ago you could do well enough, and not give any cloud overlord a single cent or byte of data about what you do, and how you do it. Or do you think that 99.999% of the use cases of a small business (and even a larger business) _cannot_ be tackled with with LibreOffice or even Microsoft Office 97? Download Office 97 from the Internet Archive and try it out. See how much has been added to the UI of the Office apps without really adding much at all.

Sum the monthly privileges of doing basic things you could do on a PC you own, and ask whether you are better off. And then ask yourself what it means if in the future most work that is increasingly done with AI assistance (i.e. all the daily nonsense that we treated as "work" even though it was then-necessary waste) can only be done if you pay tribute to one or two companies that are the only ones allowed to rent you the capacity not to do discretionary things, like listen to music, but you get your actual work done in a cost-competitive and time-competitive manner.

Ask yourself whether, by readily dismissing the idea of local AI as "useless", without qualifying it further or even understanding what's at stake, you are not skipping that brief era of personal computing, and jumping straight ahead to the dystopia of "for the price of just one coffee per month", times as many coffees as the vendors will decide are par for the course this month. Only this time, it will be a matter of getting work done.

### Self-hosting and local AI are two sides of the same coin

It's a similar topic as self-hosting some of your IT infrastructure, really. I have been on this
argument for years, for ordinary infrastructure, not just models:
[boring IT](https://overbring.com/blog/2020-01-08-boring-it-infrastructure-great/),
[make-or-buy / autarky](https://overbring.com/blog/2023-12-21-autarky-out-of-fashion/),
[digital serfdom](https://overbring.com/blog/2020-01-24-microsoft-pihole/),
[File Browser instead of Dropbox](https://overbring.com/books/elixir-file-browsing/).

Self-hosting is a hassle sometimes. So is monitoring HuggingFace for new models that might be better than what you already run, then trying them out in different quants, seeing how well they perform--and ultimately, at least for the past 8 months, coming back to Qwen3.6-35B-A3B and derivatives, and newly, to Qwen3.8-27B and derivatives, and soon, to Qwen4-27B and derivatives. FOMO and minmaxing performance out of your AI boxes is a hell of a hobby. And it takes time to stay abreast of developments, even if an agent takes care of wiring up new GGUFs or EXL3 quants.

The vast majority of people will not do it, and that is all right. The people who call themselves web-scale while they have three users and more microservices than customers, who need Kubernetes to auto-scale a crappy startup, who tell you a Proxmox VE server is a full-time job: my first Proxmox VE server went up in 2021 and has sat there for five
years without requiring a maintenance drama. [Boring is the point](https://overbring.com/blog/2020-01-08-boring-it-infrastructure-great/). Everything that is not turnkey becomes, in their telling, impossible. That is how you keep people paying a stack of despots.

There is a segment being talked out of local AI because "it doesn't do anything well" -- which is plainly false for the work they actually type. There is a technical segment being brainwashed the way they were brainwashed about AWS, microservices, MongoDB, FaaS and other "safe bets" for the future: step away from value creation, from saving money, from sovereignty, in a world drowning in open-source software that is now *easier* to build and deploy because of the incredible open-weights models we can run even on a single 16 GB GPU that costs ~$500. Heck, buy a used RTX 4060 Ti 16 GB. How can ~$500 be considered a barrier to engaging in becoming less dependent on an oligopoly, even if that will not, initially, or ever for some, entirely reduce your risk exposure to cloud AI? Madness.

### The cat, bell, the GPU

People are already rebuilding popular tools with models they run themselves. You cannot put the genie back. There are abliterated models, uncensored models, models that will answer in ways a corporate safety deck would call politically incorrect. **The cat is out of the bag. Deal with it.** Build processes to safeguard any model. Even frontier models can take stupid, destructive actions. I think banning weights after they exist is theater. I also think that people with harmful intent were not waiting around idly for `Heretic-Qwen3.8-27B-Cyber-Uncensored-MAX-Fable5-Q4_K_M.gguf` to _finally_ be released so that their roadmap of nefarious actions can be unblocked. Therefore, a common-sense guidance like "do not wire up every GGUF that looks interesting with no care or skepticism" is not even worth making.

A few entrenched companies are attempting regulatory capture, and trying to claim the next productivity step as theirs and theirs only, allegedly as the only path in which menial work can be whittled away, so that people can focus on more important things that what a 9B model on a 12 GB GPU can already do. 

They dress the grab as safety, as national security, as "open weights are dangerous," as "DeepSeek distilled us," as "Alibaba did this and that". Fundraising gets sketchier as the return story gets harder. They talk as if they have already lost the technical argument and are playing the regulatory one. You can ban whatever you want. I have enough GPUs, and some gamers are selling their older RTX and RX units online. The weights are downloaded and backed up across three disks. Stop releasing models, ban GPU sales, ban Chinese and/or open-weights models, do whatever you think will protect your IPO. Nothing you do can stop what began with the leak of the first llama model's weights, was solidified into a better trajectory for everyone thanks to Georgi Gerganov and his llama.cpp, and is now continuing with [Pirate Face](https://pirateface.co/). Latest by August 14th 2026, Qwen3.8-27B sounded once again the bell that had already sounded with DeepSeek-R1, with Qwen3.6 and even Qwen3.5 before it. *"Therefore, send not to know for whom the bell tols, it tolls for thee."*

Most of the good open weights are coming from China, not because Chinese companies are doing it out of the kindness of their corporate heart, but because China is playing _exactly_ to the weakness the American incumbents are displaying. Anyone who already owns compute, or is willing to buy a single 12 GB or 16 GB card second-hand, already has the means to cover basic and beyond-basic use cases without _ever_ paying a single subscription cent.

Gaming is still a huge industry even while wafer capacity leans toward HBM. I cannot picture a future where consumer GPUs stay permanently out of reach. The drought is a detour. When it ends, a 64 GB card will look like the 8 GB flagship did, and the people who spent those years insisting you had to rent a "digital mind" from a feudal lord will have been selling a delay.

The moral hazard is the fanboy who paid for the fanciest model telling the rest of the world that local AI cannot code, cannot work, that it is merely a toy. Thousands of people are already doing serious work on budget cards, on dual-GPU rigs, on one or more DGX Spark units. If that person wants a hobby and a Veblen sticker, that is their money. When they talk to people who have never tried a decent local AI model, they propagate the idea that the only way to benefit from AI is to willingly remain a digital serf. That is how you put the sheep in someone's pen again.

And don't forget that ultimately we are all in someone's Cave, such as NVIDIA's or AMD's. Or, ultimately, ASML's. That's the way the cookie crumbles.

## A tool is only half the story

Local, today, is a bad _product_ for people who will not _own the problem_. Cloud is a better *product* both for competent people and for those who devalue themselves into "meat proxies". Making organizations dependent on a capacity that has to be rented to keep working on things that nobody really understands anymore is not a side-effect. That's the age-old bait-and-switch business model of tricking customers into getting vendor-locked. I am not going to win over those users with this diatribe, and nobody should try either. This piece is for people who might be ready to own the problem if they knew they were allowed to, and for people who already do and were told they were wasting their time. The cave fills up because incompetence and laziness, or a lack of authorization or interest to take ownership of a problem for a better business outcome is the default, and vendors know what and whom they sell it. 

I would rather human civilization not deploy AI based on that default. It's my opinion and you do not need to share it. It's clear that, as things stand, right now local AI requires more involvement than cloud AI, at least until you're up and running. After that, things get easier, but so far never as "turnkey-ready" as installing Grok Build, linking your SuperGrok account, and clanking away.

But even if the cloud subscriptions were $10/month for infinity millions of tokens input/output, and even if you miraculously found a stack of DGX Sparks in a dumpster, with the stack ready to serve Qwen6.9-27B with 1M of tokens across 10 users in parallel, and a performance equivalent to today's GPT Astra... that still leaves the most important part of the equation out of the picture: competence.

### Competence

Cloud versus local is the easy argument, even without fictitious models and zero-cost plans or hardware, but competence is the one people skip. Give someone the best power tool in the shop: they still have to know how to use it. A trillion-parameter frontier model and a 35-billion Mixture of Experts on your desk fail the same way if you do not know how to steer it.

A tool is only half the story. The other half is knowing how to use it, which includes knowing its limits, when to remain confident and when to be wary, and taking personal responsibility for the results. The harness matters (people keep rediscovering this) for how the model behaves and how it recovers from its own stupidity. Rules you write, and rules you have the harness distill from past sessions, change _immensely_ how you **collaborate** with any model you pick. So do skills you have the model create from repeated processes. I still do not think we should anthropomorphize the thing. It is matrix multiplications on hardware. It does not have a soul, but it has context. And thus what you put into its context still determines the quality of you get.

If you treat it as a genie that will read your mind and turn "build me this" into the architecture you had in your head (if you had any to begin with), you will be disappointed. A quadrillion-parameter model cannot mind-read. If you do not say what you need, how you need it, which trade-offs might be worth investigating, which constraints are real, you are paying for a wish. On a $200 Anthropic stack that can be a hobby, a fancy car in the driveway. Fine. It is a toy. It is not a verdict on what the rest of us can do with a box we own and the best open-weights we can run.

I learned this the expensive way, twice.

### Cognitive laziness rarely if ever pays off in knowledge work

Once in 2008, as a turbine engineer, shoveling designs between CAD
and overnight CFD jobs, waiting eighteen hours to find out a variant
was junk. A colleague wanted a vendor's "pushbutton optimization"
suite. Their way of using it? No need to understand the engineering problem--just lean back, pretty graphs, per-core licenses humming on the HPC cluster. It never
left their team.

What worked was the boring version: me in the loop, low-fidelity parametric design and exploration first, kill bad regions of the design space, spend the
expensive hours only on what deserved them. I got faster *and* smarter, because I had to wait, yes, but not 18 hours behind trial-and-error runs. I had to parametrize the geometry, analyze the data (with Machine Learning, even), understand the trade-offs, prepare the next batch of experiments. The fully automated path turned a trained engineer into a machine operator. The "local" approach enabled a newly-minted turbine development engineer to design nigh-optimal turbine designs in record time, **and** to become a better engineer. I wrote the long version of that parallel in ["Vibe coding leaves me with a very sour taste"](https://overbring.com/blog/2025-08-16-vibe-coding-sour-taste/).
The punchline has not aged: *spend more tokens, you peasants* is the
same joke as *calculate more, you peasants*. I am still against vibecoding, but not against using agents for proper software _engineering_ and development.

### Vibecoding and the temptation of the one-shot prompt

The second time was vibecoding itself. Underspecified one-shots. "Build me a clone of that popular game." If the game is popular, you are measuring how much of the training data you are paying to get regurgitated, and the operator remains a meat proxy. The operator becomes the tool. The tool becomes a whimsical slot machine that eats tokens and your time in fruitless prompting, trying to slap the model towards a vague direction with no real plan, no understanding of the context of the things you want to see materialized. YouTube is full of this nonsense, because it films well. You are paying dearly for world knowledge and calling it a coding benchmark.

A collaborator, with you in the driver's seat, looks like requirements, specification, architecture, many rounds. The model does not read your mind, so you have to know what you are asking for well enough to notice when the answer is wrong. That is engineering, and it is not a job title.

[The exceptionalism of software is
unwarranted](https://overbring.com/blog/2025-09-06-software-engineering-vs-other-engineering/).
Software is different — mutability, cost of change, physics
abstracted away, but not *that* different. Coding is implementation, the way a CAD drawing is implementation. Engineering is trade-offs, architecture, failure modes, non-functionals, the engineer's accountability for the design of the system. [Everyone is an engineer in software
(allegedly)](https://overbring.com/blog/2026-05-27-everyone-is-an-engineer-now-allegedly/) is about what happens when you hand the word out like candy and then wonder why the building is fragile. I am not claiming everything deserves engineering. A mock does not, and neither does an MVP, or a throwaway exploratory prototype, which by the way is one of the best uses of local AI models. Plenty of things do require an engineering epproach however, if they are supposed to still work in two years. For those, staffing the work with people who will not own the problem is how you get a backlog of missing understanding. Giving them an expensive OpenAI Universa 6.7 ultrawork model without expecting them to engineer the system is merely getting you an unmaintainable spaghetti-code clusterfuck faster than ever, and perhaps cheaper than ever, **if** they don't keep wasting very expensive tokens by triggering rework again and again.

The human's job with any of these models is the job it always was. **Own the problem.** If you cannot explain it so another person would understand, you are not likely to get a good result from working _with_ a local AI model, and the deficit you face is older than this technology. I said that in 2023, when LinkedIn was wailing about a shortage of "skilled LLM users"; [it was not a skills shortage in GenAI](https://overbring.com/blog/2023-06-02-oh-no-we-have-no-skilled-llm-users/).

Thus, especially when working with a local AI model that has a paltry 27 billion of parameters instead of the genie-in-a-bottle that will respond with oodles of code regardless of whether your rub it the right way, you have to analyze the system, and work with the model to engineer a solution. Break it into pieces: knowledge gaps, hypotheses, a spec that constrains without encoding the answer. Rambling into a microphone can *open* a problem; it does not replace owning it. 

### Scatter, hand-off, and wishful thinking

And how will you know if the local model gives you nonsense? Remember: a fool with a tool is still a fool, even if the tool is cool and makes the vendor drool. Stay in the zone where you know enough to smell nonsense. See [the 2×2 matrix I still use](https://overbring.com/articles/2023-06-23-on-using-llm-to-get-things-done/).
That matrix has held up better than most of what has been written about this since. Keep the knowledge, and expand the known-knowns and your awareness. Institutional memory that accumulates: how this codebase does a thing, the skill you extracted because you did it twice, the cookbook, the ledger of documents that the model can maintain as the codebase changes. You can write a skill for that, like [lean-agent-flow](https://overbring.com/skills/lean-agent-flow/) for the technical stuff or [knowcarve](https://overbring.com/skills/knowcarve/) for the overarching scope that a product manager would handle. You pay for that once. Scatter, hand-off, and wishful thinking are still the three wastes, and map cleanly onto knowledge work with local models--and it's _all_ knowledge work, my dudes. For example:

- Compaction is a **hand-off** you do not control. Don't be surprised if some of the things that were discovered in the session are not anymore taken into account later. Do a hand-off instead.
- Underspecified prompts represent **wishful thinking** that _any_ model will mind-read to figure out requirements, architecture, specs. Learn you some systems and requirements engineering instead.
- Things that went wrong once and have not been captured as a "lesson learned" that lazily loads into the context when the model is about to step on the same or a similar banana peel are **scatter**; the surprise the first time around was an unknown unknown for the model, but it turns into a known unknown and then to a known known _only_ if you spend the time capturing that in a token-efficient way for the future banana-peel repeat.

Local models do not forgive incompetence. They expose it, because
there is no trillion-parameter world-knowledge crutch to hide
behind, which is useful. The people who get value out of this are
the people who were already trying to understand systems. Cognitively lazy and those who never anyway wanted to learn how things work need not apply. They were screwed long before the advent of GenAI.

### Own the problem, and collaborate

Finally, do not treat the model as a mere executor. Treat it as a collaborator. You will be surprised to find out, especially if you use a model not as a crutch but as a research partner, that even Qwen3.8-27B, that allegedly "useless" local AI model, is superintelligent in that it most certainly does a better job at online research, documentation and analysis than most product managers I've ever met. That is neither scary, disappointing, or a value judgment against people; we eat food and power the human brain, and our attention still wanders, we forget things we already know, we simplify by reducing the scope of our analysis, we do not document enough. A model does not; it eats tokens, rifles through SearXNG searches and Markdown fetched with Firecrawl, and shits documentation, code, responses, and its own limited-intelligence take on things, that often relates to its training cut-off date and more often than not relates to how you prompted, and what skill files you applied.

Separating "the brains" from "the hands" is a managerial fantasy. Sure, the "hands" that used to type in VS Code are now left more free to type a prompt, do the pre-research that goes into the prompt, etc. And the "superintelligence" will happily crank out code; in fact, it will more readily crank out code than ask for clarifications about what you need to still clarify before it cranks out code. That's why the name of the game is _delay_. Delay gratification. Resist the pull to let it code. Keep prying:

- "What is still unclear?" 
- "Where do you need a decision from me?"
- "Which decisions can we delay?"
- "Review the above adversarially"
- "Tear everything we discussed apart, treat it as a stupid idea or plan"
- "Tell me where I'm wrong"

Etc. etc. Don't let it soothe your worries that you have not been particular enough. I guarantee that you haven't, until you have. *That* is now where the meraki and the craftsmanship needs to be diverted towards: figuring what needs to really be done, with which architecture, which components, which functions each domain needs to have , in what sequence we can delay decision-making to the last responsible moment, which trade-offs are inherent in the system, which specs must be tight and which ones can be left loose and be decided later, what is the 80/20 scope right now, what is the 80/20 scope 5 turns later, which constraints are apparent, and so on and so forth.

### Delay your gratification

Meraki and craftsmanship eat the process for breakfast; they always did. And if you divert them away from code golf and patting yourself on the back for a) how amazing it was that the model one-shotted your vagueposting prompt and/or b) how much better code you write after spending 10x the amount of time it takes even Ornith-1.5-35B-A3B to write, you can focus on what really matters: fulfilling the system's or the task's requirements, or in other words, fulfilling the Jobs To Be Done without obsessing about frivolous navelgazing about how _exactly_ the code looks like, and how it's not as good as the code _you_ wrote back when you were getting paid handsomely to write beautiful code in a world in which the software developer (often named "engineer", with scant evidence of engineering competencies) was a scarce resource. Programming capacity is not anymore a scarce resource. Giving a fuck still is, and will forever be, but now it's more about whether you care enough to learn the new tricks of the trade and focus on what's really valuable (JTBDs) instead of nonsense like Emacs vs. vi, tabs vs. spaces, JetBrains vs. VSCode, Rust vs. Zig, and similar trivialities that matter squat to a model that -- sometimes, only with your guidance -- can lift an entire codebase piece by piece and reimplement it in another language.

And still: remain vigilant. Read the reasoning traces and you'll be surprised by how much you learn yourself, and how beneficial it is to notice early that some of the things the model reasons about incorrectly is because of the imprecision of human language, or because you forgot something, or you made a typo or spoke in a way that garbled the STT input, and the model took its input at face value and now tries to align what it already had in context with something that seems contradictory.

Read the reasoning traces, whether it's Qwen3.8-27B or a DeepSeek V4.1 Flash 1017.

## Who wins

Whether we let a couple of companies seize the next productivity
step is a civilizational question, and my bet is on the small ones, like mine, and of course I'm biased.

Local AI is not for everyone today. It may never be "for everyone" in the sense Windows 95 was, because the UX is not there, the limiter is real, and a lot of people want a genie more than a collaborator. I am not writing this so that they feel guilty. I am writing it so that the rest of us are not gaslit into renting a mind for work a 9B could do in the next room.

The frontier-model fanboys who have tried local AI mostly deride it
as too slow, or not smart enough. What I have figured out after
talking to them is that many of them have no idea how to use any
tool. They want the model to translate a wish into requirements,
specification, architecture, and the trade-offs. Those people are
making themselves redundant meat proxies. Cloud or local, the
dynamic is the same. Local just makes the costs and limitations visible up front. And it also keeps you honest and in the driver's seat, because it requires treading more carefully instead of trusting a godlike multitrillion-parameter model to mind-read, because it has absorbed tons of training data and will regurgitate an average solution if left unguided.

Those of us who have invested in local compute, either because we bought it early, or bought it in a rush, those of us who want to keep learning, and who do not
pretend that development of anything, _not just code_, does not require managing knowledge gaps: **those of us will win.** Those of you who are competent users of cloud plans also win, BTW, provided that you do not relegate yourself to a meat proxy.

Knowledge is a deliverable, next to a working artifact. Code that
compiles. A decision. A ledger of payments. A summary of a document.
A tutor. Clarity about what you are trying to achieve, on a machine
that belongs to you, is what will remain available long after the RAMaggeddon has passed, Anthropic and/or OpenAI's IPOs have failed to deliver the gorillions of return they project, or open-weights models stop getting published.

Personal AI as ordinary as a PC in 1996, used by people who still
know how to think: that is the better future. I sure hope that the future is not a fatter monthly plan.

But then again, those of use with a mindset of striving to understand, with the human skills of thinking of the system, with the collaboration skills to work with people _and_ with a local model, with even a paltry 12 GB GPU, and with the weights long-ago downloaded and filed away in triplicate, do not need to care.

That's why I find the hero image of this post so appropriate. 
