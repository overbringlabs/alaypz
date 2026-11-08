In my experience, many people who have spent the last year and a half
talking only to cloud frontier models have a badly distorted picture
of what is possible on a machine you own. Most of them have not spent the
time to update their knowledge. In fact, many of those actively _refuse_ to become more knowledgeable about what local AI can do in November 2026; they scoff at the mere suggestion that you can get actual work done with anything but the latest and greatest "frontier model" served by a cloud provider.

They are still in [Plato's allegorical cave](https://overbring.com/books/cave/), taking shadows on the wall for
the world. What's worse is that many of them are the shadowcasters themselves, and bring and try to keep more people in the cave.

I care about the next step of personal computing, i.e. about who gets to "own"
it, and whether you use it as a collaborator or as a machine operator.

## The Windows 95 moment is already here

A little over thirty years ago personal computing had a big-bang
moment: Windows 95. As much as fans of open-source like to hate on Windows 95, it was a world-defining operating system, not because it was great (it wasn't; Windows 98SE was way better), but because it democratized the concept of personal computing in a way that no other personal-computer
operating system had managed to do.

And yes, of course there was Windows 3.1, and DOS, and Amiga. Of course you might reminisce about this era and even be 
offended about my take on things. Still, this does not change [history](https://www.cnet.com/culture/windows-95-remains-most-popular-operating-system/): Windows 95 assisted the then-ongoing boom of PC sales, smack dab in the middle of an era in which processor MHz were regularly _doubling_, where new CPUs were coming out with _MMX_ (MultiMedia eXtensions), where modems went from being used for accessing BBSs (Bulletin Board Systems) to accessing the World Wide Web (the "Information Superhighway") via dial-up.

Windows 95 and 98, and 98SE (and software piracy, and the "pretty please do not make illegal copies of this software teehee ;)" text on the CD) ushered in a new era in _personal computer_. Within a few years, many homes in the advanced economies had a computer running it. With it came Microsoft Office, i.e. word processing, spreadsheets, early slide decks. Alongside came Windows games, and The Web. A USRobotics Sportster 28.8k or 56k modem, the screeching of the handshake, and the magical world of AltaVista and Lycos and Geocities. Kids writing homework in Word, nerding out with online research on The Lord of the Rings, or playing SimCity 3000 and Age of Empires.

That explosion in serving home use-cases is what changed the world. Microsoft did not get there by catering
only to people whose job it was to work on "computers" in general, i.e. to people already served by Windows NT.

> Those of you who will now rant about the BSDs or Linux, relax. In the 1990s neither you nor I (on Linux since 1997) were the ones defining the concept of personal computing.

Microsoft (and Intel and AMD and Cyrix, remember Cyrix?) brought personal computing the masses who were thus far on Windows 3.1, or DOS, or nothing. And it wasn't something that was limited to home use. Creating documents and searching online became _the business_; businesses small and large got a PC too. Much later, everyone got a smartphone, i.e. that is a locked-down impersonation of a personal computer that is not personal. 

During the 1990s and the early 2000s, knowing how to operate a Windows machine became commonsensical
in the advanced economies. _That_ is **democratization** of personal computing and the skills it requires; it is not John Doe rewriting something in Rust on four concurrent Claude Code sessions, or Isaak using Qwen3.8-27B to extend a three-codebase SaaS with an Elixir backend.

Since then, the world of personal computing has actually *regressed*. "My Computer" has become "This Computer". 
Operating systems that snoop on you. Vendors who [handicap their own
hardware through firmware](https://github.com/zagitta/gpu-unlock). Young people who barely have a concept of
a truly _personal_ computer: a machine that holds *your* data, does not send
it to a cloud, and where backing it up is your job, not a
subscription. I wrote about that regression when Microsoft's
Copilot+ line signalled [the death knell of the Personal Computer](https://overbring.com/blog/2024-05-22-the-death-knell-of-personal-computing/).

We are at the next such moment because the *capability* of local AI models has long crossed a
line, not because an RTX 5090 32 GB magically appeared on every desk.

In November 2026, the situation with hardware for local AI is not great, but it's also not disastrous. The notion that you need a 5090 and 32 GB is a red herring.
Inference engines such as [Strata](https://github.com/Niko1221/Strata) combined with novel multi-tier model architectures like that of [Qwen3.8-Flash-Next](https://qwen.ai/blog?id=qwen3.8-flash-next) have made as 12 GB GPU viable, provided that you have 32+ GB of RAM.

Still, DDR5 has kept getting more expensive as wafer production capacity keeps targeting HBM instead of DDR, and this has caused DDR4 prices to also explode. Thus, building a box that can run Qwen3.8-Flash-Next remains cost-prohibitive for most. For entering the world of local AI, as 12 GB GPU will do for simple cases (9B-class models) and a 16 GB GPU opens up possibilities with Qwen3.6-35B-A3B and derivatives (such as Ornith-1.5-35B-A3B) with some expert layers in RAM for a decent context window at a modest speed hit.

The sweet spot right now is a dual-GPU rig with the cheapest GPUs you can get, i.e. second-hand RTX 4060 Ti 16 GB or new RTX 5060 Ti 16 GB or Radeon RX 9060 XT 16 GB. You can get _a lot_ of work done on those 32 GB, at a fraction of the cost of buying a single RTX 5090 or Radeon R9700 with 32 GB, let alone a DGX Spark or the AMD equivalent that costs an arm and a leg for capacity at the cost of inference speed.

Right now, until the next open-weights jump lands (people are
already talking about [Qwen4](https://www.alibabacloud.com/blog/alibaba-clouds-2026-apsara-conference-full-stack-ai-roadmap-along-with-global-market-expansion-plan_603598) as if it were Christmas), the dense
model I keep coming back to on that hardware is **Qwen3.8-27B**.
When I want speed more than that last notch of thoroughness, I reach
for **Ornith 1.5-35B-A3B**, a Mixture-of-Experts model based on Qwen3.6-35B-A3B that spends a
handful of billions of active parameters per token. Fine-tunes of those
families do real work too. I have been building with them since the
spring, on budget GPUs, on machines that answer only to me. 

I bought a 4070 Super and a 4060 Ti in 2024 and 2025, sat on them
because I had no use case beyond single-shot "translate this" or "summarize this" requests with Ollama, and then in May put both of them on an X570 motherboard. These combined 28 GB of VRAM have been doing a lot of work for me since May 2026, and they have kept doing _better_ work with every new local-AI model that deserves the NVMe storage space.

The silicon did not get smarter, but the *models* did. The compute capability of the GPUs did not change, but the capability of the models they can run today
is in a different league from a year ago, when I was playing around with Qwen2.5 and Ministral-3. That is what an
appreciating asset looks like when the software side is moving, and here we have three software parts moving at once:

1. the models and the new quantization schemes like GSQ-RCO,
2. the inference engines,
3. the harnesses in which you run them.

But is that the end game? I think not. Once upon a time, an 8 GB GPU was a flagship and a 4 GB GPU, like my middle-of-the-drought Radeon RX 6500 XT 4 GB, seemed pitiful. Even so, those GPUs _today_ are still not totally useless; they are more than fine for RAG, i.e. for BGE-m3 and BGE-reranker-v2-m3 (or EmbeddingGemma-2), and for a small, heavily quantized model that can be used as a chatbot. They are practically useless for serious agentic work though.

So, 12 GB is the entry point, 16 GB is the minimum viable for local agentic coding, 32 GB is the comfortable sweet spot of capability and speed and cost, at least when it comes to VRAM. As I said, new architectures and inference engine also make use of NVMe storage and RAM. Thus, VRAM will become less important, while RAM's value in the local-AI equation will become more important. RAM is right now very expensive, but will it remain expensive forever and ever? Forever ever?

Press X to doubt. My ThinkPad W520 from 2012 already had 32 GB of DDR3 (4x 8 GB). Every PC I've built between 2023 and 2025, while DDR4 prices were sensible, has 24 to 64 GB of DDR4. I still kick myself for not going for 4x 32 GB DDR4-3200 sticks two years ago, but hey, hindsight is 20/20. As a friend says, "never read the chart backwards".

There is no physical law that says a PC in 2026 should be cost-capped at 16 or 32 GB of DDR4 or DDR5. There is also no law that says that 64, 128 or 256 GB of DDR5 should be affordable. There is also no physical law that says that a GPU from 2025 is cost-capped at 16 GB, that 32 GB VRAM should cost more than a used car, or that NVIDIA's segmentation is some kind of absolute truth about what is possible.

It's all about the market: wafer capacity got yanked toward HBM for the (ending? TBD)
data-center boom, consumer DRAM and GPU memory went into a drought,
and the timeline bifurcated: there is a timeline in which every PC has 64 GB DDR5 at sensible 2025-era prices but we have no local AI models, and the current timeline, where we have increasingly amazing models that can run at higher quantizations fast enough, but you pay through the nose for VRAM and RAM.

That drought will not last forever, because markets change. Whether this happens in 2, 3 or 5 years, nobody can tell, and anybody who claims otherwise is bullshitting you. But think ahead 10 years, where it's easier to consider what is _unlikely_ to be true by then, assuming that nothing catastrophic or weird happens. Just like an 8 GB GPU or a 16 GB PC in 2026 looks _quaint_, do you not think that a 16 GB GPU or a 64 GB PC will look quaint by then?

Eventually, VRAM/RAM capacities that we now treat as an economical no-no will stop
being a data-center punchline. When prices and capacity resume
something like "normal" behaviour, the question is whether we will have already
handed the capability of the local-AI equivalent of personal computing to a handful of despotic cloud overloads.

I wish for ordinary speech to sound like *"we have local AI at home"*,
the way people once said *"we have a Windows 95 PC at home."* I.e., inference capacity you truly own and control, "personal AI" being as commonplace among people
who can afford it and want it as personal computing became in the
nineties. The more people stay in the cave, and the more "AI bros" and Claude fanboys keep others in the cave, the longer the "Windows XP era" of local AI is delayed.

## What that actually enables

Having a chatbot in a tab is the least interesting version of this wished-for future. Far more interesting is the outlook of outright owning hardware that can help you do work you would otherwise do entirely by yourself, or you'd have to pay a stranger's cloud computer to do, but without the stranger and their nanny-state restrictions on what you can do.

Agentic coding is the least of my concerns, to be quite honest. It's an early-adopter obsession, and a pre-crossing-the-chasm obsession of software developers with what is already eating software developers' lunch. The "Windows XP era" of local AI -- and I'm saying "Windows XP" and not "Windows 95", because Windows XP was where we saw billions already having crossed the personal-computing chasm globally -- is one that makes it possible for a private person, a family, a small business to get their menial tasks done, locally, without worries of privacy breaches or operating expenses for things that totally, _absolutely_ **do not** deserve a subscription plan to a trillion-parameter frontier model.

That means all the boring stuff, the menial administrative boring stuff that one might want to do, but is always a PITA to get done because it involves websites, spreadsheets, fragmented sources of information like email attachments, and files stored on your laptop, and online searches. Bank statements and reminders, an integration with your smartphone, keeping track of things that you are owed and you owe. It also includes catering to the desires of people of all ages that want to understand more; the knowledge-thirsty. Doing online research and discussing it with a local model, using a local model as a sparring partner or a tutor, doing your homework, organizing your collection of files, learning any skill with a tailored learning plan and a chat interface with a model that will grill you. And all that, without shipping your questions, your worries, your progress, your chat trajectories to an opaque vendor who will use your input as part of the training set of the next model.

The Windows-XP era will reasonably have the a similar spread of "normie use-cases" (and I do not use "normie" derogatorily here) as the Windows 95 era of the personal-computing boom had: online research, writing, learning things, figuring things out, and this includes things other people (worse, a cloud-AI vendor) might scoff at. Most importantly, it will include things that you would not want to share with the cloud nanny-state, such as discussing something of a personal nature with a model, such as health concerns, money and budget, a family mess.

Though I mostly use local AI models for agentic coding, I too am a normie, as are all of us, to a varying degree. I have sat with a local model and discussed email and social-media confrontations. I have pasted instant-messaging back-and-forths from a break-up that lasted way too long. I have discussed my approach in communication, what I didn't do well, what I should do better next time, the rough edges I should file, and what I should not carry as a conscience burden going forward. What matters here is that all this is totally innocuous, and I would still not feel comfortable sending those chats to a cloud-AI vendor, because it's personal. And even though I have nothing to hide, it's literally nobody else's business other than mine. 

Businesses are normies too, and the most normie thing a business can do is start getting rid of its ancient, document-based approaches to getting things done. By "document" I mean any artifact that contains a piece of the puzzle of information pertaining to a situation, a case. It can be an email, a PDF, a spreadsheet, a memo. It can be a case of a legal dispute, an RFQ, an offer, a discussion across numerous emails, a negotiation, a business plan. All this is scattered across datastores, in varying formats, and the biggest challenge of a business is to bring all that together and distill what's happening, where the situation stands, what decisions need to be made, etc.

The average office laborer's work is disgustingly zero-value-adding and menial to the point of cognitive atrophy. "Business processes" that involve aligning a human brain's knowledge of a situation across disparate documents. Agents can do this better, so that people can focus on actually value-adding work. 

What's more important: **local** AI agents can do that better **and** in a way that does not expose private information or other proprietary matters to cloud-AI providers, such as contracts, roadmaps, research, budgets, prices, names, contact information, etc. -- information that I do not want ending up in the training set of a fuzzy thing that my business does not control. 

Note that I do not assume the vendor is necessarily malicious. I assume that they and their vibecoded infrastructure can get hacked. Most importantly, I assume that nobody can really know what they keep, let alone audit whether and how they mitigated a security breach, or what they actually use from what we send them. 

A business that uses local AI is not science fiction in 2026. It's entirely feasible. I run [my industrial-equipment trading business](https://isatek.gr) this way. A local model called by an open-source harness connects via an open-source MCP server to my self-hosted IMAP server to access emails, to my own software tools for inventory management, product data management, invoice tracking, etc. using MCP servers that Qwen3.8-27B added, reads data (invoices, pricelists, etc.) from the self-hosted Samba network drive, keeps track of who owes what, what needs to be delivered by when, what awaits pickup at which factory, which offers are expiring, which purchase orders have come in, etc. in Markdown files.

Market knowledge, prices, customer data and all proprietary information stays inside the building. In fact, it has a _higher_ likelihood of staying inside the building compared to entrusting a human operations manager with confidentiality. And it's available 24/7, does not tire, does not complain, is nigh-autistically meticulous (provided that you have `KILL.md` files for typical business processes), and costs me pennies of electricity. In 6 months of use, the 2500 EUR I paid for my dual-5060 dedicated AI server has already paid of for itself, compared to labor costs and the hassle that goes hand-in-hand with dealing with employees, because beyond being just an operations-management clerk, agents running locally on Qwen and its derivatives are also a personal assistant with access to my calendar, a sparring partner for product and business strategy, a diligent online researcher, a summarizer of product PDFs, and whatever else I need it for.

Thus, the prize is ownership of local AI capability is the next productivity step: individuals
and small companies keeping the gains, instead of renting them back
from a handful of firms that are already not particularly profitable
and already in cahoots with each other, and perhaps one day with captured regulators too.

Watching people who think that renting the latest fancy trillion-parameter model capacity is the only way to do things argue that future away annoys me to no end. It is disconnected from reality in the future, and from a reality that's possible _today_ with local AI. What, did you think that you need Claude Magnum 8.7 ultramax supercoder and a proprietary closed-source harness geared towards maximum token burn across five $200 monthly plans to do all of the above? Please.

## The long tail is a search box, not a hot rod

In 2026, ChatGPT is supposedly already at a billion users globally. Talk to non-technical
people who actually use it, and you will find that many of them are not on a paid plan.
They hit a daily allowance of their trivial use-cases and fall back to whatever free Gemini
Flash-Lite (the crappiest of models, but unlimited usage AFAICT) will still serve them. 

Ask them what they use it for: 
- Find me this product.
- Discuss this email.
- Check this online.
- [situation] What do you think?
- Polish this email.
- Look at my spreadsheet.
- Tell me what people are saying about this product.
- How do I make lasagna? 
- Do my homework.

For the most part, those use cases represent a more chatty, natural-language, convenient web search. It is Altavista or Word 95 or Excel 95 with a conversation. Pretty much none of that needs a trillion-parameter model. A lot of
it was already within the capabvilities of a model from April 2026, i.e. of Qwen 3.6-35B-A3B, which is also insanely fast (because it's an MoE model) even on entry-level hardware. Heck, a lot of the above is certainly doable by a 9B-class model. Heckity-heck, a lot of the above is even doable by Spark-X2.6-4B or LFM2.5-8B-A1B.

Two years ago you wanted 70B for that quality, and 70B was impossible to run locally because of its architecture and KV-cache VRAM cost per token. Nowadays on 32 GB VRAM you can fit [Nemotron-3.5-Bolt-74B-A9B IQ2 QAT](https://overbring.com/ai-benchmarks/2026-10-31-nvidia-nemotron-35-bolt-74b-a9b-iq2-qat-gguf-rtx-5060-ti-16gb-x2-layer-split-llama-server-cuda/), which wipes the floor with older models of 2025 and 2024 that you could not even run on affordable local-AI hardware.

Architectural advances, quantization-aware training, better quantization schemes, distillation of cloud models (totally justified, in my view), new training approaches and finetunes, new and improved inference engines, better harnesses: the technological mine is probably not going to be exhausted anytime soon. What used to be considered "frontier/SOTA" capability keeps getting squeezed into smaller and smaller GGUF files, sometimes with 1M native context window (Nemotron-3.5-Lightning, Spark-X2.6-4B). 

When Qwen3.8-27B sat next to a cloud frontier model
from six months earlier when it dropped mid-August 2026m, and can absolutely get serious software engineering work done.
It is total overkill for "search this and tell me what people think" and similar use cases.

A 16 GB entry-level GPU that will eventually not cost what it currently costs (call it $450 in a saner market) can already run the 35B MoE class at decent speed and quality. Divide that by $20 a month for a typical ChatGPT entry-level plan and you have paid it back in two years, during and after which you ask the model whatever
you want, while nobody is snooping. A Mac Mini with 16 GB of unified memory can run a 9B-class model (or Spark-X2.5-9B that matches or surpasses Qwen3.5-9B) and get the basic stuff above done. Sure, it will be slower than the cloud tab and afford you not maximum context. Sure, it's one chat at a time (or run it with `--parallel N` with `N > 1`). Sure, it's not as turnkey as opening a browser tab. But it will get your normie use cases done.

And if you face a usage spike? Just buy DeepSeek Platform credits for DeepSeek Flash or a Qwen token plan that will give you access to Qwen3.8-Flash, provided that you do not care where you data ends up. If you do care about that, and keep facing usage spikes that make your one box feel limiting, invest in a second box and scale your compute capacity and your costs in steps that amortize. You do not need to swear fealty to a cloud despot for basic stuff.

The danger is that we are inundated with hot takes from people who
feel they need full-precision weights on a stack of $5k to $10k DGX Spark or Mac Studio units, because they are spending their time more with building hot rods than actually using their "vehicles" for anything other than "AI-maxxing". That is their prerogative, fine.  Tuning a very expensive rack instead of getting work done is not the bulk of the market, it's either an AI consultancy business or a hobby. 

The local-AI market is in the early-adopters phase. Most people you see posting on X or HuggingFace are not the mass market that represents a future "Windows XP era". The market will need to cross the chasm, eventually. As we established, the mass market does not need the trillion-parameter capabilities. The enthusiasts and the SOTA fanboys take
*their* use cases (agentic coding, a bajillion tokens burned every week, multiple concurrent sub-agents, decked-out harnesses with tens of skills, refactoring a codebase, etc.) and declare local AI useless because a sensibly priced box cannot match cloud compute. 

True, as a trade-off, for *those* use cases, but then again those use cases are not representative of a maturing market. They might be the majority of *spend* right
now, but the long tail is not rewriting code into Rust or doing genome research, or electronics research. The long tail is comprised of people
using Gemini Flash or ChatGPT for free, living with "you're doing
this too much, come back later," asking ultra-basic things, i.e. using the
thing as a search engine that can also consult them.

If you listen only to the Veblen-priced cloud serfs, you will believe that the only
way to get _anything_ done is to become a serf like the loud-and-proud serf stuck in a cave that they are. 

What's worse: the prisoners of the cave are recruiting others by spouting off nonsense about how amazing the cave is. This is a result of a mix of identitarian nonsense, a sense of superiority from paying tribute and showing off how much tribute they are paying (i.e. portraying subscription costs as a proxy of how advanced they are at using AI), and -- perversely -- a conquered status they want everyone else to share. 

Imagine the late 1990s with that mindset: a subscription for Word, Word running an opaque classifier on what you may type and censoring what you can write based on Microsoft's Terms & Conditions, a meter on AltaVista searches. Disgusting.

Value creation with AI at planetary scale will not happen because a department of 20
became 2 people burning tokens like there's no tomorrow. It will happen the way PCs
happened: more people get access to **private AI capacity** that is limited only by what money they feel comfortable spending on their AI PC, just like in the 1990s we were only limited by how much money we feel comfortable spending on a new PC with the Pentium 133 because the one we had was the 486DX2/33, where (for the younger ones) 133 and 33 denotes MHz of a single-core CPU, i.e. what has now peaked with modern consumer-grade CPUs at around 4.5 GHz and God knows how many cores and threads. And that 33 to 133 MHz jump happened over the span of **3 years** (DX2 in 1992, Pentium 133 in 1995, almost exactly 3 years apart).

**That**, in my view, is where we are right now with local AI models, and latest by the release of Qwen3.8-27B: in the Pentium 133 era. Some might even argue that we are even earlier, i.e. at the 286/386 era, where personal computing **really** got started, albeit without the niceties of Windows 95 that brought a PC into every home that could afford it. How can you **not** be excited by what the future may bring? What will the "Ryzen 5 3600/5600"-class (the all-time individual desktop bestseller of the modern era, powerful and affordable, and still in use) local AI model eventually look like?

And how can you not be distrustful of everything and everyone who disparages that timeline, instead claiming that local-AI is useless, because it cannot one-shot a simple videogame, i.e. that 27B parameters of "world knowledge" are not sufficient to have captured and later regurgitate that videogame?

## The trade-offs are real

It's not all roses, and local AI is a different kind of beast. Local AI is not "like what you run on the cloud, but free and private." You pay differently,
and you _wait_ differently, and pretending otherwise is how you lose the
argument with someone who has a credit card and multiple $200-per-month subscriptions or has been granted a budget for corporate use.

On 32 GB of VRAM you can hold a 256k-token context, which is
workable, and if you actually *use* that whole window you pay in
throughput. One session, maybe two, depending on how you split the
card into slots; maybe you run 2 concurrent slots, each with 128k context, or 4x65k. Any of those three is totally workable for the basic things that normie use-cases require. 128k is IMO the bare minimum for agentic coding, because models like Qwen3.8-27B reason a lot, and therefore a large part of that context window will be use for reasoning about how to get things done. 256k is more than enough. Models with a 1M context window anyway start to lose coherence long before the window is exhausted, so the "but muh 1M context window" is a moot argument, if the model gets Alzheimers at 320k tokens deep. Not every model behaves the same, and this might be an effect of cloud-AI providers serving "dumber" models, i.e. more heavily quantized models and or KV caches, during peak demand. Then again, that is another chink in the cloud-AI hypers' armor: you never know what exactly you're getting served.

But anyway, say you want more than one session at once, or a subagent or more.  In `llama-swap` (an orchestrator that allows you to serve multiple models that get hot-swapped into VRAM/RAM) all that is just model profiles: four
slots at 64k, or two slots at 128k (a main that does the work and a
slot you delegate to), or one slot at the full 256k. Agentic flows (take this document, call an API or an MCP tool, do something, call
something else) typically want about 64k as a floor, so a native 256k model
gives you four concurrent jobs if you are disciplined. 

Two different
models co-resident is a hassle; you are fighting VRAM by hand, and VRAM is the scarce resource, so it's better to have one model's weights in VRAM. Swapping models costs wall-clock: load time is a few seconds from an NVMe SSD, longer from a SATA SSD, and what feels like aeons from a SATA HDD. And then, you pay for "prefill", i.e. for the VRAM to get populated by a re-tokenized context of your discussion thus far Cloud does not make you care about any of that, though you still pay in terms of tokens burned when you switch model. 

With cloud AI you burn tokens, the harness dispatches multiple parallel sub-agents (each without the workers-vs.-context-window trade-off that I explained above), you get there faster and you also empty the weekly usage pool faster. Capacity is the vendor's problem. They scale up and down, sometimes they serve you a dumber model version, they give you another subagent session, but you can parallelize work. It remains the vendor's problem until the invoice arrives; then, it becomes your problem. Your operating expenses grow. Fair, if you can afford it.

With local AI, if your job is to code all day and you need that kind of fan-out, you buy a
second box and you start building a small fleet, which is a real barrier for anyone who is not an enthusiast right now. Most people will not
put up with the effort needed for the setup and the orchestration. That does not make the single-box case fake, it just means that "I need 5 parallel subagents to run at full speed and costs be damned, because I have a hard deadline for the next software release" is a fundamentally different Job-To-Be-Done / requirement than "a family or business PC that thinks and gets the menial work done".

That is a genuine trade-off; for some kinds of work it is limiting. For a lot of work it is just slower, which means you wait. However, waiting is not always bad. Waiting means that you have to be more deliberate with what you do, especially if you use that limited local-compute capacity and sub-SOTA local models to get agentic-coding work done. It means that you cannot simply "vibecode", expecting that the model will read your mind and arrive at an implementation despite your lack of effort at setting constraints and requirements on what will be developed, and how.

You will need to discuss about requirements, provide a nudge, ask a correction, and you can do that better by **front-loading knowledge** instead of front-loading decisions. Start a 128k or 256k session, us Handy for Speech-To-Text, and just explain what you are after. Braindump on this thing. Give it your idea, your concept, tell it your worries--after all, nobody is listening, it all stays local. If language models (whether small or large, because today's small is last year's large) are good at anything, it's in natural-language processing, so give it context, copiously. Ask it to organize what you told it. Ask it to find gaps that deserve to be closed. Ask it to grill you, or ask it to review your input adversarially, i.e. poke holes into it. Ask it to evaluate whether what you provided is sufficient to get started with implementation; it most likely won't be.

Put in the effort, and Qwen3.8-27B is more than capable to help you till the ground before it starts planting seeds. Heck, even Qwen3.6-35B-A3B is more than capable of doing all that. Then, once you've done that necessary prework that vibecoders and one-shot benchmarkers apparently do not do, **then** you can proceed with a structured approach, again. Requirements, architecture, specifications, implementation, tests. All this keeps you in the driver's seat. Vibecoders and those who rely on the trillion-parameter SOTA model to "bake a glorious cake" without providing any other guidance will get... whatever cake the model regurgitates from its training data. Then, they'll keep spending tokens like the good serfs they are, in order to make the initial cake into the cake they want, but have not bothered to specify. They don't drive the process; they are the ones being driven into a trial-and-error, wasteful process that makes the vendor very, very happy.

Thus, having to wait is not always a problem. Being forced to stay in the loop is how you avoid cognitive surrender on the 
task. You still know what is going on, because you went and kept going through the **necessary** value-adding work that is, essentially, knowledge management for your clanker buddy, and for yourself, and for anyone else who might work with a clanker buddy on the codebase.

Then again, that is the agentic-coding use case, which as we've established does not represent the Windows-XP-era majority, i.e. the long tail of the market. Not every use case needs 32 GB, and not every use case needs four
slots, and not every use case needs more than 64k of context. A Qwen 3.6-class Mixture of Experts model with a 262k window,
split across two slots, is already two conversations at once, i.e. it serves two concurrent businesspeople, or mom and dad. Split the VRAM four-ways, and now a family or a small business gets its work done. 

Plenty of people, plenty of days, need just one chat going at once. Even plenty of small businesses will rarely need more than one session. The human is the bottleneck, until you start automating things with agents that do things autonomously, and that is still, firmly, not mass-market territory. Judging local AI against the built-in, token-burn-incentivizing laxity of a cloud subscription is a category error. Use cases have
requirements. A million-token carrot that auto-compacts and bills
you for the reprocessing is a smart way of burning more tokens so that you don't even suffer the temporary inconvenience (oh mon dieu!) of handing off to a fresh session. The advertised 1M context window is how they get you to stay in one session until compaction
fires; periodic token burn through automatic compaction is one of the ways in which they eventually sell you the next-bigger plan. The harness
that "just works" by spawning sub-agents is the same token-burner with a friendlier face, cute animations, etc. Don't fall for that.

Setup knowledge is a barrier to entry. `llama-swap`, slot counts, KV cache and its quantization, speculative decoding, parallel slots,
which quant affords you how much context, etc. We are early in a boom; of course the UX is still
ugly. It will get easier. Enthusiasts will put up with the hassle, but the Windows 95 masses will not, until someone packages it. Some already do that, with nice GUIs that help you easily load models, but in my experience they still expect a lot from the user, and the automatic choices they make are not smart enough so that the user can squeeze maximum performance from the hardware. That's fine; the hassle does not make the underlying capability of local AI fake.

The other side of the ledger is how you pay. A cloud subscription or
an OpenRouter invoice is operating expense: pay-as-you-go, or a
plan that pretends to be a buffet until the weekly pool is empty.
A local box is capital expenditure up front, then electricity, then
almost nothing when the fans are not spinning. One year of a heavy
cloud plan is already in the neighbourhood of a capable local rig.
In year two, three, four you keep paying rent on capacity you could
have bought. Maintenance, by the way, is one of the first jobs you
can hand to the box itself: after weeks of wiring HuggingFace models
into llama-swap's `config.yaml` by hand, I asked Qwen3.6-35B-A3B to
turn the ritual into a skill. For months I have pasted a model-card
URL and let the agent fetch the weights and write the profile.

The other upside of local: you always know what you are running. You
learn what quality to expect for what kind of input. Nobody serves
you a worse quant because it is peak time in Beijing or San
Francisco. Nobody retires the workhorse you finally learned. Stick
to an older model on OpenRouter and you often pay *more*. Qwen3.8-27B
plus web search and web fetch already covers pretty much anything
that is not a super-niche research toy. Qwen4, when it drops, will
be a nice-to-have upgrade on silicon you already own. That is a
rare case in technology: the card sits still, the models get better.

## What a token actually costs, if you pretend the box never sleeps

Say you run Qwen3.8-27B NVFP4 on 32 GB. You will not run it 24/7.
If you did, you could put the output tokens next to API list prices
and next to a plan's monthly allowance. From this server's
llama-swap SQLite log, average tok/s regardless of context depth:

```sql
sqlite> SELECT AVG(tokens_per_second) FROM activity WHERE model_id = "Qwen3.8-27B-NVFP4-vision";
43.4856426336161
```

At 43.5 tokens per second, that is about **114 million output tokens
per month** if the card decoded every second of the month. Naive:
it ignores prefill, which burns watts and wall-clock without filling
the "output" column, and it ignores the fact that you are in the
loop. Kept simple, output only.

[OpenRouter list prices](https://openrouter.ai/models?input_modalities=text&categories=programming&order=pricing-low-to-high),
USD per million *output* tokens, times 114.3 Mtok. Qwen3.8-27B is
not Opus. I put Opus in anyway, out of curiosity.

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
dedicated box: X870E, Ryzen 7 9700X, 16 GB DDR5-6000, 2× RTX 5060 Ti
16 GB, 850 W 80 Plus Gold PSU, E-ATX case, SATA SSD for Debian 13,
NVMe for weights. The 5060s are power-limited at 160 W: a few
percent off token-generation speed, silicon that does not cook,
longevity over bragging. At the wall, full blast, about **500 W**.

That is about the cheapest *useful* dual-GPU 32 GB CUDA rig you can
assemble in late 2026. Dual RX 9060 XT 16 GB is the AMD fork: often
cheaper per gigabyte of VRAM, Vulkan instead of CUDA, no NVFP4. You
usually lose on prefill; generation can be close. Dual 9070 XT is a
different shopping trip — those cards sit nearer a thousand euros
each, which blows the "budget 32 GB" thesis. GPU street prices move
weekly. The point is 32 GB of VRAM on two modest cards, not a 5090.

Electricity: **$0.40/kWh**. That is high for cheap-power US states,
high for some EU countries, roughly right for expensive-power EU
households (Eurostat's EU average all-in is nearer €0.28; Germany
and Ireland live up near €0.39). Conservative against local, on
purpose. 500 W × 730 hours × $0.40 ≈ **$146/month** if the box
generated every hour of the month. It will not.

Amortize the $3000 **straight-line to zero**: cost ÷ (years × 12).
No residual, no interest, no resale. I am *not* counting that you
might sell the cards into a drought for half, or more, of what you
paid. That would make the local case look better than I want to
claim.

| Straight-line years | Rig (USD/month) | Power (USD/month) | Total for 114.3 Mtok | USD/Mtok |
| --- | --- | --- | --- | --- |
| 1 | 250.00 | 146 | 396.00 | 3.46 |
| 2 | 125.00 | 146 | 271.00 | 2.37 |
| 3 | 83.33 | 146 | 229.33 | 2.01 |
| 4 | 62.50 | 146 | 208.50 | 1.82 |
| 5 | 50.00 | 146 | 196.00 | 1.72 |

Under this fictitious 100% decode duty cycle, local is **not**
cheaper per output token than Grok Build 0.1 at $2/Mtok. It is in
the same band as the cheap APIs once you have amortized a few years,
and a lot cheaper than Sonnet and Opus on the open list. You also
do not get Opus quality. A $200/month plan, if you actually get
hundreds of millions of tokens out of it, is a better sticker than
$146 of 24/7 wall power — until you notice that you do not run 24/7,
that Claude Code will chew a weekly pool for breakfast, and that the
plan is a meter with a smile.

What the table refuses to capture is the shape of the cost. Cloud is
a hose. Local is a speed limiter: 43 tok/s, one session at full
context, two if you split the window. For the early-adopter who
wants five parallel sub-agents rewriting a codebase, the limiter
hurts. For a family or a small office — one chat, maybe two, "take
this PDF," "what do the emails say," "run this flow" — the limiter
is the product. You cannot spend the box down to zero on Tuesday.
You can only wait. When you are not generating, the bill falls
toward idle: on this chassis, on the order of **80 W**, call it a
few tens of dollars a month, not $146. Real use, in Open WebUI or
Grok Build or whatever harness, is a few minutes of cranking, then
you. Duty cycle is low. Prefill is in that duty cycle; I still have
not credited local for input tokens the API would have billed.

## The comparison that actually moves a business

Forget 114 million tokens. Put a clerk on the menial work already
described: mail, spreadsheets, "where does this stand," a report
when you ask. Eight hours a day, five-ish days, fully loaded.

Greece, small firm: on the order of **€1,500/month** all-in. Most
richer economies: **$2,000–2,500**. The box, if we are unkind to it
and assume it generates at 500 W for those same eight hours every
calendar day, plus 80 W the rest of the time, at $0.40/kWh, is
roughly **$65/month** of electricity. Capex $3,000.

Against €1,500, the rig's cash payback is **about two months**.
Against $2,500, closer to **six weeks**. After that you are paying
power and the occasional disk. The clerk still sleeps, still
forgets, still cannot be audited the way a Markdown trail can. I am
not claiming the model *is* a person. I am claiming that for the
zero-value-adding alignment of documents, the napkin already
clears, in a low-wage country, before the first quarter is over.
That is the ISATEK story with extra arithmetic: the dual-5060 box
paid for itself against labour in months, not against Grok Build's
spot price.

A $200 Max plan is a different animal. Fair: $200 is more than idle
power, less than a person. It is also tied to the fortunes of two
US labs if you stay in that stack. Plans have gotten worse:
chatty harnesses, shrinking pools, models that move under you,
retirement of the one that actually worked. I could not find a
clean on-the-record Anthropic sentence that "Max should be $1,000."
What I can find is the revealed price of the same job: Accenture
engineers hitting **$500–$1,000/month** on Claude before the firm
capped them; reporting in the same season of **$500–$2,000 per
engineer per month** at other large buyers. If $200 is a promotional
sticker on labour substitution, it is not unthinkable that the
sticker moves. API list prices can move the same way. Local's
unpleasant property — you already bought the limiter — becomes the
hedge.

Chinese APIs (DeepSeek, Qwen) are excellent money. I use them for
work I do not mind leaving the building. OpenRouter with a
zero-retention claim is the same idea if you believe the claim. I
do, for some jobs. That does not replace the box for mail, invoices,
names, a breakup, a balance sheet. It is overflow. The horse I will
not tie to OpenAI or Anthropic's wagon is the one that holds the
proprietary day.

Resale: I am not putting a credit in the table. In a drought you
might get money back; after the next real GPU generation, a 5060 Ti
may look quaint and sell for peanuts. Both can be true in sequence.
The second half is the mass-market punchline. We have already
crossed the line where **32 GB is enough** for the long tail. In two
or three years, when wafer allocation is less deranged, a 5080-class
card at 5060-class money with 32 or 48 GB is not a crazy picture.
Then the used 5060s and 9060s, or a single aging 5090 32 GB or
Radeon AI PRO R9700 32 GB, become the Windows 95 PC of this story:
one card, bought cheap, short stints, "tell me this, take this PDF,
check the mail." You do not need more VRAM than that for that job.
You needed it for the hot-rod. The hot-rod is not the market.

The local number is: always on, nothing left the room, a limiter
instead of a meter. The plan number is: pace yourself until Friday.
I would rather own the limiter.

Transpose the current cloud deal back to 1995. Someone tells you
that a personal computer will cost the equivalent of a hundred euros
a month, and that Microsoft Word will refuse a sentence because it
breaches a safety policy, and that you may not search for a topic
because it breaches terms of service. Whose job is it to tell me
what I do with my computer? It is my computer. I will do what I want
with it. That is not a brief for doing shady things. It is about
who gets to classify the contents of your head as they pass through
a keyboard.

The machine, and what you type into it, is an extension of what you
have in your mind. Nobody has managed to censor that. Vendors are
reducing legal liability by putting an imperfect classifier between
your fingers and the input box. There is no perfect classifier for
human language. Sessions that stop responding because a nanny
decided you were doing "cybersecurity" research, or something merely
adjacent to a banned category, are the point. How did we inch
backwards into something this illiberal — the wrong-think of 1984,
except the telescreen is a ToS and a model that is covering the
vendor's ass? I do not want a nanny state overhead on thinking,
including boring, legal, personal thinking.

## Why people stay in the cave

I keep meeting people who think the only way to use AI is the latest
cloud model at an immense monthly cost, even for work that last
year's weights could do. Especially for coding, there is a large
misunderstanding that the only way to get working software is
whatever frontier name is fashionable this month, and that anything
else is wasting time.

They are caught, not uniformly stupid. The mechanisms are old.

People attach their name to the latest sexiest fad — Claude Code,
the frontier model of the month — the way they attached it to a blue
bubble on a phone. They do not need the thing. The name *is* the
product. I have watched this with Microsoft, with Apple, with every
incumbent that learned to sell belonging. The cave is comfortable if
the herd is in it.

Corporates go with the obvious overpriced solution because otherwise
they look like laggards, or like they are rocking the boat. I spent
a decade watching this movie under other titles: Lean, Agile, SAFe,
"AI strategy" slide decks from a firm that will happily bill for
executive absolution. [The Incredible Story of
Deft](https://overbring.com/books/deft/) is that movie as a novel.
[Lo and Behold, X!](https://overbring.com/books/lo-and-behold-x/) is
the same movie as a decade in a kingdom. Miracle-cure frameworks.
Alluring narratives of success at organizations that do not look
like yours. Passionate experts. The current AI hype is Deft in a new
cloth.

You buy a very expensive German car and, because you paid a lot, you
convince yourself it is the pinnacle of automotive. Cloud AI has the
same Veblen structure. Twenty dollars, fifty, a hundred, two hundred
a month, and rising, for the *privilege* of sending private data to
a vendor. Cache hits, cache misses, price per million tokens of
input and output — a meter on a hose you do not own. Subscriptions
get encrusted. Usage pools shrink. Serving gets cheaper for them and
dumber for you, and you cannot choose the quant. Locally you pick
the trade-off yourself.

The rental shift is not new. Dropbox if you wanted to share files.
OneDrive hijacking the PC until it stopped feeling like *your*
computer. App stores. Ripping CDs into MP3 and FLAC, then Spotify.
Office as a subscription. Microsoft wants a tribute, Spotify wants
a tribute, Apple wants a tribute, Google wants a tribute. Sum the
monthly privileges of doing basic things you could do on a disk you
own, and ask whether you are better off. I have been on this
argument for years, for ordinary infrastructure, not just models:
[boring IT](https://overbring.com/blog/2020-01-08-boring-it-infrastructure-great/),
[make-or-buy / autarky](https://overbring.com/blog/2023-12-21-autarky-out-of-fashion/),
[digital serfdom](https://overbring.com/blog/2020-01-24-microsoft-pihole/),
[File Browser instead of Dropbox](https://overbring.com/books/elixir-file-browsing/).
Self-hosting is a hassle sometimes. The vast majority of people
will not do it, and that is all right. The people who call
themselves web-scale while they have three users and more
microservices than customers, who need Kubernetes to auto-scale a
crappy startup, who tell you a Proxmox box is a full-time job: my
first Proxmox VE server went up in 2021 and has sat there for five
years without requiring a maintenance drama. [Boring is the
point](https://overbring.com/blog/2020-01-08-boring-it-infrastructure-great/).
Everything that is not turnkey becomes, in their telling,
impossible. That is how you keep people paying a stack of despots.

There is a segment being talked out of local AI because "it doesn't
do anything well" — which is false for the work they actually type.
There is a technical segment being brainwashed the way they were
brainwashed about AWS, microservices, MongoDB, Elastic: step away
from value creation, from saving money, from sovereignty, in a
world drowning in open-source software that is now *easier* to
build because of the same models. Madness.

People are already rebuilding popular tools with models they run
themselves. You cannot put the genie back. There are abliterated
models, uncensored models, models that will answer in ways a
corporate safety deck would call incorrect. **The cat is out of the
bag. Deal with it.**

A few entrenched companies, with captured regulators, are trying to
claim the next productivity step as theirs. They dress the grab as
safety, as national security, as "open weights are dangerous," as
"DeepSeek distilled us," as "Alibaba did this and that." Fundraising
gets sketchier as the return story gets harder. They talk as if they
have already lost the technical argument and are playing the
regulatory one. You can ban whatever you want. I have GPUs. The
weights are downloaded and backed up across three disks. Stop
releasing models, ban GPU sales, do whatever you want.

Most of the good open weights are coming from China, because China
is playing exactly to the weakness the incumbents are displaying.
Anyone who already owns compute, or is willing to buy a single 12 GB
or 16 GB card second-hand, already has their card out of the bag.
Gaming is still a huge industry even while wafer capacity leans
toward HBM. I cannot picture a future where consumer GPUs stay
permanently out of reach. The drought is a detour. When it ends, a
64 GB card will look like the 8 GB flagship did, and the people who
spent those years insisting you had to rent a mind from a landlord
will have been selling a delay.

The moral hazard is the fanboy who paid for the fanciest model
telling the rest of the world that local AI cannot code, cannot
work, is a toy. Thousands of people are already doing serious work
on budget cards. If that person wants a hobby and a Veblen sticker,
that is their money. When they talk to people who have never tried a
local box, they propagate the idea that the only way to benefit from
AI is to be a digital serf. That is how you put the sheep in
someone's pen again.

## A tool is only half the story

Cloud versus local is the easy argument. Competence is the one
people skip. Give someone the best power tool in the shop: they
still have to know how to use it. A trillion-parameter frontier
model and a 35-billion Mixture of Experts on your desk fail the same
way if you do not.

A tool is only half the story. The other half is knowing how to use
it, which includes knowing its limits, being wary, and taking
personal responsibility for the results. The harness matters —
people keep rediscovering this — for how the model behaves and how
it recovers from its own stupidity. Rules you write, and rules you
have the harness distill from past sessions, change the work. I
still do not think we should anthropomorphize the thing. It is
matrix multiplications on hardware. It does not have a soul. How you
work with it still determines what you get.

If you treat it as a genie that will read your mind and turn "build
me this" into the architecture you had in your head, with clean
tests, you will be disappointed. A quadrillion-parameter model
cannot mind-read. If you do not say what you need, how you need it,
which trade-offs you already made, which constraints are real, you
are paying for a wish. On a $200 Anthropic stack that can be a
hobby, a fancy car in the driveway. Fine. It is a toy. It is not a
verdict on what the rest of us can do with a box we own.

I learned this the expensive way, twice.

Once in 2008, as a turbine engineer, shoveling designs between CAD
and overnight CFD jobs, waiting eighteen hours to find out a variant
was junk. A colleague wanted a vendor's "pushbutton optimization"
suite: lean back, pretty graphs, per-core licenses humming. It never
left his team. What worked was the boring version: me in the loop,
low-fidelity first, kill bad regions of the design space, spend the
expensive hours only on what deserved them. I got faster *and*
smarter. The fully automated path turned a trained engineer into a
machine operator. I wrote the long version of that parallel in
[Vibe coding leaves me with a very sour
taste](https://overbring.com/blog/2025-08-16-vibe-coding-sour-taste/).
The punchline has not aged: *spend more tokens, you peasants* is the
same joke as *calculate more, you peasants*.

The second time was vibe coding itself. Underspecified one-shots.
"Build me a clone of that popular game." If the game is popular, you
are measuring how much of the training data you are paying to get
regurgitated. The operator is a meat proxy. YouTube is full of this,
because it films well. You are paying dearly for world knowledge and
calling it a coding benchmark.

A collaborator, with you in the driver's seat, looks like
requirements, specification, architecture, many rounds. The model
does not read your mind. You have to know what you are asking for
well enough to notice when the answer is wrong. That is engineering,
and it is not a job title.

[The exceptionalism of software is
unwarranted](https://overbring.com/blog/2025-09-06-software-engineering-vs-other-engineering/).
Software is different — mutability, cost of change, physics
abstracted away — but not *that* different. Coding is
implementation, the way a CAD drawing is implementation. Engineering
is trade-offs, architecture, failure modes, non-functionals,
accountability for the system. [Everyone is an engineer in software
(allegedly)](https://overbring.com/blog/2026-05-27-everyone-is-an-engineer-now-allegedly/)
is about what happens when you hand the word out like candy and then
wonder why the building is fragile.

I am not claiming everything deserves engineering. A mock does not.
An MVP often does not. Plenty of things do, if they are supposed to
still work in two years. For those, staffing the work with people
who will not own the problem is how you get a backlog of missing
understanding.

The human's job with any of these models is the job it always was.
Own the problem: if you cannot explain it so another person would
understand, the deficit is older than this technology. I said that
in 2023, when LinkedIn was wailing about a shortage of "skilled LLM
users" —
[it was not a skills shortage in GenAI](https://overbring.com/blog/2023-06-02-oh-no-we-have-no-skilled-llm-users/).
Break it into pieces: knowledge gaps, hypotheses, a spec that
constrains without encoding the answer. Rambling into a microphone
can *open* a problem; it does not replace owning it. Review: a fool
with a tool is still a fool, even if the tool is cool and makes the
vendor drool. Stay in the zone where you know enough to smell
nonsense —
[the 2×2 I still use](https://overbring.com/articles/2023-06-23-on-using-llm-to-get-things-done/).
That matrix has held up better than most of what has been written
about this since. Keep the knowledge. Institutional memory that
accumulates: how this codebase does a thing, the skill you extracted
because you did it twice, the cookbook, the ledger. You pay for that
once. Scatter, hand-off, and wishful thinking are still the three
wastes. Compaction is a hand-off you do not control.

Local models do not forgive incompetence. They expose it, because
there is no trillion-parameter world-knowledge crutch to hide
behind, which is useful. The people who get value out of this are
the people who were already trying to understand the system.

Separating "the brains" from "the hands" is a managerial fantasy. I
have never seen it produce a shared picture of the work. Meraki and
craftsmanship eat the process for breakfast; they always did.

## Who wins

Whether we let a couple of companies seize the next productivity
step is a civilizational question, and my bet is on the small ones —
like mine.

The frontier-model fanboys who have tried local AI mostly deride it
as too slow, or not smart enough. What I have figured out after
talking to them is that many of them have no idea how to use any
tool. They want the model to translate a wish into requirements,
specification, architecture, and the trade-offs. Those people are
making themselves redundant meat proxies. Cloud or local, the
dynamic is the same. Local just makes the invoice honest.

Those of us who have invested in compute — bought it early, or
bought it in a rush — who want to keep learning, and who do not
pretend that development does not require managing knowledge gaps:
**those of us will win.**

Knowledge is a deliverable, next to a working artifact. Code that
compiles. A decision. A ledger of payments. A summary of a document.
A tutor. Clarity about what you are trying to achieve, on a machine
that belongs to you, is the part that does not expire with the
model of the month.

Personal AI as ordinary as a PC in 1996, used by people who still
know how to think: that is the better future. A fatter monthly plan
is not.
