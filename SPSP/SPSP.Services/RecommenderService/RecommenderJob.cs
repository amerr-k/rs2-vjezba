using SPSP.Services.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Quartz;
using Quartz.Impl;
using Microsoft.Extensions.Logging;

namespace SPSP.Services.RecommenderService
{
    [DisallowConcurrentExecution]
    public class RecommenderJob : IJob
    {
        private readonly IRecommenderService recommenderService;
        private readonly ILogger<RecommenderJob> logging;

        public RecommenderJob(IRecommenderService recommenderService, ILogger<RecommenderJob> logging)
        {
            this.recommenderService = recommenderService;
            this.logging = logging;
        }

        public Task Execute(IJobExecutionContext context)
        {
            logging.LogInformation("Recommend");
            recommenderService.Recommend();
            return Task.CompletedTask;
        }
    }
}
