import React from 'react';
import { Target, Flame, Trophy, BookOpen, CheckCircle2, Circle } from 'lucide-react';
import { StatsCard } from './StatsCard';
import { CodeBlock } from './CodeBlock';
import { ProgressItem } from './ProgressItem';
import { TryItCard } from './TryItCard';
import { Badge } from './ui/badge';
import { Accordion, AccordionContent, AccordionItem, AccordionTrigger } from './ui/accordion';
import { Card } from './ui/card';
import { ScrollArea } from './ui/scroll-area';

export default function DockerLearn() {
  const journeyItems = [
    { title: 'docker-start', status: 'completed', progress: 100 },
    { title: 'docker-get', status: 'completed', progress: 100 },
    { title: 'docker-images', status: 'current', progress: 50 },
    { title: 'docker-login', status: 'available' },
    { title: 'docker-build', subtitle: '100%', status: 'completed', progress: 100 },
    { title: 'docker-create', status: 'available' },
    { title: 'docker-build-2', subtitle: '100%', status: 'completed', progress: 100 },
    { title: 'docker-network', status: 'available' },
    { title: 'docker-run', status: 'locked' },
    { title: 'docker-compose', status: 'locked' },
  ];

  const labsItems = [
    { title: 'Your First Container - Run Ubuntu', completed: true },
    { title: 'Port Mapping and Container Ports', completed: true },
    { title: 'Environment Variables and Configuration', completed: true },
    { title: 'Volume Mounts and Data Persistence', completed: false },
    { title: 'Container Logs and Debugging', completed: false },
    { title: 'Multi-Stage Builds - Optimizing Images', completed: false },
    { title: 'Networking Basics - Container Communication', completed: false },
    { title: 'Docker Compose - Multi-Container Apps', completed: false },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100">
      <div className="flex h-screen">
        {/* Left Sidebar - Journey */}
        <div className="w-72 bg-white border-r border-slate-200 flex flex-col shadow-sm">
          <div className="p-6 border-b border-slate-200">
            <h2 className="text-slate-900">Your Journey</h2>
            <p className="text-slate-500 text-sm mt-1">Track your progress</p>
          </div>
          <ScrollArea className="flex-1">
            <div className="p-4 space-y-2">
              {journeyItems.map((item, index) => (
                <ProgressItem key={index} {...item} />
              ))}
            </div>
          </ScrollArea>
        </div>

        {/* Main Content */}
        <div className="flex-1 overflow-auto">
          <div className="max-w-5xl mx-auto p-8 space-y-8">
            {/* Stats Cards */}
            <div className="grid grid-cols-3 gap-6">
              <StatsCard
                icon={Target}
                value="0%"
                label="Accuracy"
                gradient="bg-gradient-to-br from-purple-500 to-purple-600"
              />
              <StatsCard
                icon={Flame}
                value="0"
                label="Disaster Streak"
                gradient="bg-gradient-to-br from-pink-500 to-rose-500"
              />
              <StatsCard
                icon={Trophy}
                value="0"
                label="Completed"
                gradient="bg-gradient-to-br from-cyan-500 to-blue-500"
              />
            </div>

            {/* Main Content Card */}
            <Card className="border-0 shadow-lg">
              <div className="p-8">
                <Badge className="bg-gradient-to-r from-purple-600 to-pink-600 text-white border-0 mb-4">
                  Interactive Learning
                </Badge>

                <h1 className="text-slate-900 mb-6">Running Your First Container</h1>

                {/* Understanding Section */}
                <Accordion type="single" defaultValue="item-1" collapsible className="mb-8">
                  <AccordionItem value="item-1" className="border border-slate-200 rounded-lg px-6 bg-blue-50/50">
                    <AccordionTrigger className="hover:no-underline">
                      <div className="flex items-center gap-3">
                        <BookOpen className="w-5 h-5 text-blue-600" />
                        <span className="text-slate-900">Understanding the Command</span>
                      </div>
                    </AccordionTrigger>
                    <AccordionContent className="pt-4 pb-2">
                      <div className="space-y-6">
                        <div className="bg-white rounded-lg p-5 border border-slate-200">
                          <div className="flex items-start gap-3 mb-3">
                            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
                            <div className="flex-1">
                              <p className="text-slate-700 text-sm font-semibold">
                                Welcome to Docker! 🐳
                              </p>
                            </div>
                          </div>
                          <p className="text-slate-600 text-sm ml-5">
                            Let's start with the most basic command - running a simple "Hello World" container.
                          </p>
                        </div>

                        <div>
                          <p className="text-slate-700 mb-3 text-sm">
                            <strong>What is docker run hello-world?</strong>
                          </p>
                          <p className="text-slate-600 text-sm mb-3">
                            The <code className="bg-slate-100 px-2 py-1 rounded text-xs">hello-world</code> image is Docker's official test image.
                            It's tiny (just a few KB), runs instantly, prints a welcome message, and exits. Perfect for your first container!
                          </p>
                          <CodeBlock code="docker run hello-world" />
                        </div>

                        <div className="space-y-4">
                          <p className="text-slate-700 text-sm font-semibold">What happens when you run this command:</p>

                          <div className="flex items-start gap-3">
                            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
                            <div>
                              <p className="text-slate-700 text-sm">
                                <strong>Downloads</strong> the hello-world image (if you don't have it locally)
                              </p>
                            </div>
                          </div>

                          <div className="flex items-start gap-3">
                            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
                            <div>
                              <p className="text-slate-700 text-sm">
                                <strong>Creates</strong> a new container from that image
                              </p>
                            </div>
                          </div>

                          <div className="flex items-start gap-3">
                            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
                            <div>
                              <p className="text-slate-700 text-sm">
                                <strong>Starts</strong> the container and runs its default command
                              </p>
                            </div>
                          </div>

                          <div className="flex items-start gap-3">
                            <div className="w-2 h-2 rounded-full bg-blue-600 mt-2" />
                            <div>
                              <p className="text-slate-700 text-sm">
                                <strong>Shows</strong> the output, then the container stops
                              </p>
                            </div>
                          </div>
                        </div>

                        <div>
                          <p className="text-slate-700 mb-3 text-sm">
                            <strong>Why hello-world?</strong>
                          </p>
                          <div className="bg-slate-50 border border-slate-200 rounded-lg p-4 space-y-3">
                            <div className="flex gap-3">
                              <span className="text-blue-600 text-sm">✓</span>
                              <span className="text-slate-600 text-sm">Official Docker image for testing</span>
                            </div>
                            <div className="flex gap-3">
                              <span className="text-blue-600 text-sm">✓</span>
                              <span className="text-slate-600 text-sm">Super lightweight (only a few kilobytes)</span>
                            </div>
                            <div className="flex gap-3">
                              <span className="text-blue-600 text-sm">✓</span>
                              <span className="text-slate-600 text-sm">Verifies Docker is installed and working correctly</span>
                            </div>
                            <div className="flex gap-3">
                              <span className="text-blue-600 text-sm">✓</span>
                              <span className="text-slate-600 text-sm">Perfect for learning how containers work</span>
                            </div>
                          </div>
                        </div>

                        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4">
                          <p className="text-slate-700 text-sm">
                            <strong>💡 Pro tip:</strong> After the first run, the image is cached locally.
                            Running it again will be instant since Docker won't need to download it again!
                          </p>
                        </div>
                      </div>
                    </AccordionContent>
                  </AccordionItem>
                </Accordion>

                {/* Try It Section */}
                <TryItCard
                  title="Your Turn - Try It Now!"
                  description="Let's verify your Docker installation by running the hello-world container. This will download a test image and run it."
                  command="docker run hello-world"
                />
              </div>
            </Card>
          </div>
        </div>

        {/* Right Sidebar - Labs */}
        <div className="w-80 bg-white border-l border-slate-200 shadow-sm">
          <div className="p-6 border-b border-slate-200">
            <h2 className="text-slate-900">Hands-On Labs</h2>
            <p className="text-slate-500 text-sm mt-1">Practice exercises</p>
          </div>
          <ScrollArea className="h-[calc(100vh-100px)]">
            <div className="p-4 space-y-2">
              {labsItems.map((item, index) => (
                <div
                  key={index}
                  className={`p-3 rounded-lg border transition-all duration-200 ${
                    item.completed
                      ? 'bg-green-50 border-green-200 hover:bg-green-100'
                      : 'bg-slate-50 border-slate-200 hover:bg-slate-100'
                  } cursor-pointer`}
                >
                  <div className="flex items-start gap-3">
                    {item.completed ? (
                      <CheckCircle2 className="w-5 h-5 text-green-600 mt-0.5 flex-shrink-0" />
                    ) : (
                      <Circle className="w-5 h-5 text-slate-400 mt-0.5 flex-shrink-0" />
                    )}
                    <span className="text-sm text-slate-700">{item.title}</span>
                  </div>
                </div>
              ))}
            </div>
          </ScrollArea>
        </div>
      </div>
    </div>
  );
}
