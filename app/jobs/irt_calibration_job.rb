class IRTCalibrationJob < ApplicationJob
  queue_as :default
  
  def perform
    """
    Run IRT parameter calibration
    Scheduled weekly to update question difficulty/discrimination
    """
    
    service = IRTCalibrationService.new
    result = service.calibrate_all_questions
    
    Rails.logger.info("🔬 IRT Calibration complete: #{result[:calibrated]} questions calibrated")
    
    result
  end
end

